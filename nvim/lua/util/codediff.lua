local M = {}

function M.picker_keys()
  return {
    input = {
      keys = {
        ["<a-c>"] = { "codediff", mode = { "n", "i" } },
        ["<a-b>"] = false,
        ["<a-B>"] = { "open_commit_pr", mode = { "n", "i" } },
      },
    },
    list = {
      keys = {
        ["<a-c>"] = { "codediff", mode = { "n", "x" } },
        ["<a-b>"] = false,
        ["<a-B>"] = { "open_commit_pr", mode = { "n", "x" } },
      },
    },
    preview = {
      keys = {
        ["<a-c>"] = "codediff",
        ["<a-b>"] = false,
        ["<a-B>"] = "open_commit_pr",
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

local function git(cwd, args)
  local result = vim.system(vim.list_extend({ "git", "-C", cwd }, args), { text = true }):wait()
  return result.code == 0 and vim.trim(result.stdout) or nil
end

-- Same lookup order as CodeDiff: the current buffer's repo, else cwd's.
local function repo_root()
  local dir = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  return (vim.fn.isdirectory(dir) == 1 and git(dir, { "rev-parse", "--show-toplevel" }))
    or git(vim.fn.getcwd(), { "rev-parse", "--show-toplevel" })
end

-- Git doesn't track a branch's parent. Candidates are the branch it was created
-- from (its oldest reflog entry, which may have moved on since) and every local
-- branch HEAD contains; the one fewest commits behind HEAD wins. Descendant
-- branches are deliberately not candidates: once this branch gains commits they
-- look exactly like a parent that has moved on.
local function parent_branch(root, current)
  local parent, distance
  -- min_count 1 skips the current branch and siblings at the same commit, but a
  -- fresh branch still matches what it was created from.
  local function consider(ref, min_count)
    local count = tonumber(git(root, { "rev-list", "--count", ref .. "..HEAD" }))
    if count and count >= min_count and (not distance or count < distance) then
      parent, distance = ref, count
    end
  end

  local log = current ~= "" and git(root, { "reflog", "show", "--format=%gs", "refs/heads/" .. current })
  local created_from = log and log:match("branch: Created from (%S+)$")
  if created_from and created_from ~= "HEAD" then
    consider(created_from, 0)
  end

  local merged = git(root, { "for-each-ref", "--merged=HEAD", "--format=%(refname:short)", "refs/heads/" }) or ""
  for _, ref in ipairs(vim.split(merged, "\n", { trimempty = true })) do
    consider(ref, 1)
  end
  return parent
end

local function open_against_parent(args_for)
  local root = repo_root()
  if not root then
    Snacks.notify.warn("Not in a git repository", { title = "CodeDiff" })
    return
  end

  local current = git(root, { "branch", "--show-current" }) or ""
  local default = git(root, { "symbolic-ref", "--quiet", "--short", "refs/remotes/origin/HEAD" })
  if default and current == default:gsub("^origin/", "") then
    Snacks.notify.warn(current .. " is the default branch, so it has no parent to diff against", { title = "CodeDiff" })
    return
  end

  local parent = parent_branch(root, current)
  if not parent then
    Snacks.notify.warn("Could not find a parent branch", { title = "CodeDiff" })
    return
  end
  vim.cmd({ cmd = "CodeDiff", args = vim.list_extend({ "--repo", root }, args_for(parent)) })
end

function M.open_branch_diff()
  open_against_parent(function(parent)
    return { parent .. "...HEAD" }
  end)
end

function M.open_branch_history()
  open_against_parent(function(parent)
    return { "history", parent .. "..HEAD" }
  end)
end

return M
