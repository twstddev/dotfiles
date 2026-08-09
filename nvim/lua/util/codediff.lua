local M = {}

function M.picker_keys()
  return {
    input = {
      keys = {
        ["<a-c>"] = { "codediff", mode = { "n", "i" } },
        ["<a-b>"] = { "browse_commit", mode = { "n", "i" } },
      },
    },
    list = {
      keys = {
        ["<a-c>"] = { "codediff", mode = { "n", "x" } },
        ["<a-b>"] = { "browse_commit", mode = { "n", "x" } },
      },
    },
    preview = {
      keys = {
        ["<a-c>"] = "codediff",
        ["<a-b>"] = "browse_commit",
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

return M
