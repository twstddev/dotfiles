local M = {}

function M.picker_keys()
  return {
    input = {
      keys = {
        ["<a-c>"] = { "codediff", mode = { "n", "i" } },
        ["<a-b>"] = { "open_commit_pr", mode = { "n", "i" } },
      },
    },
    list = {
      keys = {
        ["<a-c>"] = { "codediff", mode = { "n", "x" } },
        ["<a-b>"] = { "open_commit_pr", mode = { "n", "x" } },
      },
    },
    preview = {
      keys = {
        ["<a-c>"] = "codediff",
        ["<a-b>"] = "open_commit_pr",
      },
    },
  }
end

function M.open_commit(picker, item)
  if not (item and item.commit) then
    return
  end

  local cwd = item.cwd or picker:cwd()
  picker:norm(function()
    picker:close()
    vim.cmd({ cmd = "CodeDiff", args = { "--repo", cwd, item.commit .. "^", item.commit } })
  end)
end

function M.open_commit_browser(picker, item)
  if not (item and item.commit) then
    return
  end

  local cwd = item.cwd or picker:cwd()
  picker:norm(function()
    picker:close()

    local previous_cwd = vim.fn.getcwd()
    vim.cmd({ cmd = "lcd", args = { cwd } })
    local ok, err = pcall(Snacks.gitbrowse.open, { commit = item.commit })
    vim.cmd({ cmd = "lcd", args = { previous_cwd } })
    if not ok then
      error(err)
    end
  end)
end

function M.open_commit_pr(picker, item)
  if not (item and item.commit) then
    return
  end

  local cwd = item.cwd or picker:cwd()

  picker:norm(function()
    local result = vim
      .system({ "git", "rev-parse", "--verify", item.commit .. "^{commit}" }, { cwd = cwd, text = true })
      :wait()
    if result.code ~= 0 then
      Snacks.notify.error("Could not resolve commit " .. item.commit, { title = "GitHub PR" })
      return
    end

    local commit = vim.trim(result.stdout)
    picker:close()

    local previous_cwd = vim.fn.getcwd()
    local restore_cwd = vim.fn.haslocaldir() == 1 and "lcd" or vim.fn.haslocaldir(-1, 0) == 1 and "tcd" or "cd"
    vim.cmd({ cmd = "lcd", args = { cwd } })
    local ok, err = pcall(Snacks.gh.api.request, function(_, prs)
      vim.schedule(function()
        prs = prs or {}
        if #prs == 0 then
          Snacks.notify.warn("No pull request is associated with " .. commit:sub(1, 12), { title = "GitHub PR" })
          return
        end

        local function open(pr)
          if pr then
            vim.ui.open(pr.html_url)
          end
        end

        if #prs == 1 then
          open(prs[1])
          return
        end

        Snacks.picker.select(prs, {
          prompt = "Open pull request for " .. commit:sub(1, 12),
          format_item = function(pr)
            local state = pr.merged_at and "merged" or pr.state
            return ("#%d [%s] %s"):format(pr.number, state, pr.title)
          end,
        }, open)
      end)
    end, {
      endpoint = ("repos/{owner}/{repo}/commits/%s/pulls"):format(commit),
      header = { Accept = "application/vnd.github+json" },
    })
    vim.cmd({ cmd = restore_cwd, args = { previous_cwd } })

    if not ok then
      error(err)
    end
  end)
end

return M
