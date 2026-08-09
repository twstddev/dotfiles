local M = {}

local WINDOW_ICON = " "
local WINDOW_COLUMN_WIDTH = 20

local patched = false

function M.ask_agent(context_template, input_prompt)
  local cli = require("sidekick.cli")
  local _, context = cli.render(context_template)
  if not context then
    return
  end

  vim.ui.input({ prompt = input_prompt }, function(input)
    input = input and vim.trim(input) or ""
    if input == "" then
      return
    end

    local text = {}
    vim.list_extend(text, context)
    table.insert(text, {})
    table.insert(text, { { input } })
    cli.send({ text = text, submit = false })
  end)
end

local function tmux_windows()
  local lines = require("sidekick.util").exec({
    "tmux",
    "list-panes",
    "-a",
    "-F",
    "#{pane_id}\t#{window_name}",
  }, { notify = false })

  local windows = {}
  for _, line in ipairs(lines or {}) do
    local pane_id, window_name = line:match("^(%%%d+)\t(.*)$")
    if pane_id then
      windows[pane_id] = window_name
    end
  end
  return windows
end

local function patch_tmux_sessions()
  local tmux = require("sidekick.cli.session.tmux")
  local original_sessions = tmux.sessions

  tmux.sessions = function(...)
    local sessions = original_sessions(...)
    local windows = tmux_windows()

    for _, session in ipairs(sessions) do
      session.mux_window = windows[session.tmux_pane_id]
    end

    return sessions
  end
end

local function insert_window_column(result, window)
  for index, part in ipairs(result) do
    if part[2] == "Special" and part[1]:match("^%[") then
      local insert_at = index + 2

      if window and window ~= "" then
        local used_width = vim.api.nvim_strwidth(WINDOW_ICON) + vim.api.nvim_strwidth(window)
        table.insert(result, insert_at, { WINDOW_ICON, "Special" })
        table.insert(result, insert_at + 1, { window, "Title" })
        table.insert(result, insert_at + 2, {
          string.rep(" ", math.max(2, WINDOW_COLUMN_WIDTH - used_width)),
        })
      else
        table.insert(result, insert_at, { string.rep(" ", WINDOW_COLUMN_WIDTH) })
      end

      return
    end
  end
end

local function patch_cli_picker()
  local select = require("sidekick.cli.ui.select")
  local original_format = select.format

  select.format = function(state, picker)
    local result = original_format(state, picker)
    local session = state.session
    if not session then
      return result
    end

    local window = session.mux_window or (session.parent and session.parent.mux_window)
    insert_window_column(result, window)
    return result
  end
end

function M.setup(opts)
  require("sidekick").setup(opts)

  if patched then
    return
  end
  patched = true

  patch_tmux_sessions()
  patch_cli_picker()
end

return M
