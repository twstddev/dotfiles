local M = {}

local WINDOW_ICON = " "
local WINDOW_COLUMN_WIDTH = 20

local patched = false

local function show_popup(session)
  if not vim.env.TMUX_PANE or not session or session.backend ~= "tmux" or not session.mux_session then
    return false
  end
  local popup_id = session.mux_session:match("^__agent_popup_(%d+)$")
  if not popup_id then
    return false
  end

  local util = require("sidekick.util")
  local owner = util.exec({
    "tmux",
    "show-options",
    "-qv",
    "-t",
    "=" .. session.mux_session .. ":",
    "@agent_popup_owner",
  }, { notify = false })

  if not owner or owner[1] ~= "@" .. popup_id then
    return false
  end

  local client = util.exec({ "tmux", "display-message", "-p", "-t", vim.env.TMUX_PANE, "#{client_name}" })

  if not client or not client[1] then
    util.error("Could not find the tmux client for the agent popup")
    return true
  end

  util.exec({ "tmux", "select-window", "-t", session.tmux_pane_id })
  vim.system({
    "/bin/sh",
    vim.fn.expand("~/.config/tmux/agent-popup.sh"),
    owner[1],
    session.cwd,
    client[1],
  }, { text = true }, function(result)
    if result.code ~= 0 then
      vim.schedule(function()
        util.error("Could not open the agent popup: " .. vim.trim(result.stderr or ""))
      end)
    end
  end)
  return true
end

function M.toggle()
  local cli = require("sidekick.cli")
  if not vim.env.TMUX_PANE then
    return cli.toggle()
  end
  require("sidekick.cli.state").with(function(state, attached)
    if show_popup(state.session) then
      return
    end

    local opts = { filter = { session = state.session.id } }
    if attached then
      cli.show(opts)
    else
      cli.toggle(opts)
    end
  end, { attach = true })
end

function M.ask_agent(context_template, input_prompt)
  local cli = require("sidekick.cli")
  local _, context = cli.render(context_template)
  if not context then
    return
  end

  local submit = true

  vim.ui.input({
    prompt = input_prompt,
    win = {
      keys = {
        ["<M-CR>"] = {
          function(win)
            submit = false
            win:execute("confirm")
          end,
          mode = "i",
        },
      },
    },
  }, function(input)
    input = input and vim.trim(input) or ""
    if input == "" then
      return
    end

    local text = {}
    vim.list_extend(text, context)
    table.insert(text, {})
    table.insert(text, { { input } })
    cli.send({ text = text, submit = submit })
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

local function patch_tmux_start()
  local tmux = require("sidekick.cli.session.tmux")
  local original_start = tmux.start

  tmux.start = function(session)
    if not vim.env.TMUX_PANE then
      return original_start(session)
    end

    local util = require("sidekick.util")
    local owner = util.exec({ "tmux", "display-message", "-p", "-t", vim.env.TMUX_PANE, "#{window_id}" })
    if not owner or not owner[1] then
      return
    end
    local helper = vim.fn.expand("~/.config/tmux/agent-popup.sh")
    if not util.exec({ "/bin/sh", helper, "--ensure", owner[1], session.cwd }) then
      return
    end

    local popup = "__agent_popup_" .. owner[1]:sub(2)
    local pane_format = "#{session_id}:#{pane_id}:#{pane_pid}:#{session_name}:#{pane_current_path}"
    for _, running in ipairs(tmux.sessions()) do
      if
        running.mux_session == popup
        and running.tool.name == session.tool.name
        and require("sidekick.cli.session").cwd(running) == session.cwd
      then
        session:spawn({ "tmux", "display-message", "-p", "-t", running.tmux_pane_id, pane_format })
        return
      end
    end

    local cmd = {
      "tmux",
      "new-window",
      "-P",
      "-t",
      "=" .. popup .. ":",
      "-F",
      pane_format,
    }
    session:add_cmd(cmd)
    -- tmux parses trailing semicolons as command separators even in argv.
    for i, arg in ipairs(cmd) do
      cmd[i] = arg:gsub(";$", "\\;")
    end
    session:spawn(cmd)
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
  patch_tmux_start()
  patch_cli_picker()
end

return M
