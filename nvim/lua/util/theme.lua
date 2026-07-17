-- Reads the shared theme selection written by the `theme` shell command
-- (see zsh/theme.zsh) from ~/.config/theme/current and applies it.
--
-- The state file is a set of KEY=value lines; we only care about:
--   THEME_NVIM      the colorscheme name to load
--   THEME_NVIM_BG   "light" | "dark" (matters for single-scheme themes
--                   like gruvbox/everforest/solarized where background
--                   selects the mode)
--
-- Applied at startup only (config-only switching): reload = restart nvim.

local M = {}

-- Fallback used when the state file is missing or unreadable.
M.fallback = { colorscheme = "catppuccin-mocha", background = "dark" }

local function state_file()
  return vim.env.THEME_STATE_DIR
    and (vim.env.THEME_STATE_DIR .. "/current")
    or (vim.fn.expand("~/.config/theme/current"))
end

-- Parse THEME_NVIM / THEME_NVIM_BG out of the state file.
function M.read()
  local path = state_file()
  local fd = io.open(path, "r")
  if not fd then
    return M.fallback
  end
  local colorscheme, background
  for line in fd:lines() do
    local key, val = line:match("^([%w_]+)=(.*)$")
    if key == "THEME_NVIM" then
      colorscheme = val
    elseif key == "THEME_NVIM_BG" then
      background = val
    end
  end
  fd:close()
  return {
    colorscheme = colorscheme or M.fallback.colorscheme,
    background = (background == "light" or background == "dark") and background
      or M.fallback.background,
  }
end

-- Set background then load the colorscheme, falling back on any error.
function M.apply()
  local sel = M.read()
  vim.o.background = sel.background
  local ok = pcall(vim.cmd.colorscheme, sel.colorscheme)
  if not ok and sel.colorscheme ~= M.fallback.colorscheme then
    vim.o.background = M.fallback.background
    pcall(vim.cmd.colorscheme, M.fallback.colorscheme)
  end
end

return M
