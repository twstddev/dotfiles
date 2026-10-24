-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local del = vim.keymap.del

map({ "n", "v", "x", "i" }, "<C-c>", "<Esc>")

del("n", "<S-h>")
del("n", "<S-l>")
del({ "i", "x", "n", "s" }, "<C-s>")

-- AeroSpace uses Alt+J/K for window focus.
del({ "n", "i", "v" }, "<A-j>")
del({ "n", "i", "v" }, "<A-k>")
map("n", "<C-A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<C-A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<C-A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<C-A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<C-A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<C-A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

if vim.g.vscode then
  local vscode = require("vscode")

  -- Remap folding keys
  vim.keymap.set("n", "zM", function()
    vscode.call("editor.foldAll")
  end, { noremap = true, silent = true })
  vim.keymap.set("n", "zR", function()
    vscode.call("editor.unfoldAll")
  end, { noremap = true, silent = true })
  vim.keymap.set("n", "zc", function()
    vscode.call("editor.fold")
  end, { noremap = true, silent = true })
  vim.keymap.set("n", "zC", function()
    vscode.call("editor.foldRecursively")
  end, { noremap = true, silent = true })
  vim.keymap.set("n", "zo", function()
    vscode.call("editor.unfold")
  end, { noremap = true, silent = true })
  vim.keymap.set("n", "zO", function()
    vscode.call("editor.unfoldRecursively")
  end, { noremap = true, silent = true })
  vim.keymap.set("n", "za", function()
    vscode.call("editor.toggleFold")
  end, { noremap = true, silent = true })

  vim.keymap.set("n", "]d", function()
    vscode.call("editor.action.marker.next")
  end, { noremap = true, silent = true })
  vim.keymap.set("n", "]w", function()
    vscode.call("editor.action.marker.next")
  end, { noremap = true, silent = true })
  vim.keymap.set("n", "]e", function()
    vscode.call("editor.action.marker.next")
  end, { noremap = true, silent = true })

  vim.keymap.set("n", "[d", function()
    vscode.call("editor.action.marker.prev")
  end, { noremap = true, silent = true })
  vim.keymap.set("n", "[w", function()
    vscode.call("editor.action.marker.prev")
  end, { noremap = true, silent = true })
  vim.keymap.set("n", "[e", function()
    vscode.call("editor.action.marker.prev")
  end, { noremap = true, silent = true })

  vim.keymap.set("n", "]h", function()
    vscode.call("workbench.action.compareEditor.nextChange")
  end, { noremap = true, silent = true })

  vim.keymap.set("n", "[h", function()
    vscode.call("workbench.action.compareEditor.previousChange")
  end, { noremap = true, silent = true })

  vim.keymap.set("n", "]x", function()
    vscode.call("merge-conflict.next")
  end, { noremap = true, silent = true })

  vim.keymap.set("n", "[x", function()
    vscode.call("merge-conflict.previous")
  end, { noremap = true, silent = true })

  del("n", "grn")
  del("n", "gra")
  del("n", "grr")
  del("n", "gri")
  del("n", "grt")

  vim.keymap.set({ "n", "x" }, "gd", function()
    vscode.call("editor.action.revealDefinition")
  end, { noremap = true, silent = true })
  vim.keymap.set({ "n", "x" }, "gr", function()
    vscode.call("editor.action.goToReferences")
  end, { noremap = true, silent = true })
  vim.keymap.set({ "n", "x" }, "gI", function()
    vscode.call("editor.action.goToImplementation")
  end, { noremap = true, silent = true })
  vim.keymap.set({ "n", "x" }, "gy", function()
    vscode.call("editor.action.goToTypeDefinition")
  end, { noremap = true, silent = true })
  vim.keymap.set({ "n", "x" }, "gD", function()
    vscode.call("editor.action.revealDeclaration")
  end, { noremap = true, silent = true })
  vim.keymap.set({ "n", "x" }, "gai", function()
    vscode.call("editor.showIncomingCalls")
  end, { noremap = true, silent = true })
  vim.keymap.set({ "n", "x" }, "gao", function()
    vscode.call("editor.showOutgoingCalls")
  end, { noremap = true, silent = true })

  vim.keymap.set({ "n", "x" }, "<C-w>q", function()
    vscode.call("workbench.action.closeEditorsAndGroup")
  end, { noremap = true, silent = true })
  vim.keymap.set({ "n", "x" }, "<C-w>c", function()
    vscode.call("workbench.action.closeEditorsAndGroup")
  end, { noremap = true, silent = true })

  -- map("n", "j", function()
  --   if vim.v.count == 0 then
  --     vscode.call("cursorDown")
  --   else
  --     return "j"
  --   end
  -- end, { expr = true })
  --
  -- map("n", "k", function()
  --   if vim.v.count == 0 then
  --     vscode.call("cursorUp")
  --   else
  --     return "k"
  --   end
  -- end, { expr = true })

  vim.keymap.set({ "n", "x" }, ",", function()
    vscode.call("whichkey.show")
  end, { noremap = true, silent = true })
else
  Snacks.toggle.zoom():map("<A-m>")

  map({ "n", "i", "x" }, "<A-;>", function()
    local nes = require("sidekick.nes")
    -- local suggestion = require("copilot.suggestion")

    -- if suggestion.is_visible() then
    --   LazyVim.create_undo()
    --   suggestion.accept()
    --   -- This is a temporary hack to make sure that in typescript files copilot suggestions appear more than one line at a time.
    --   suggestion.accept()
    -- end

    if vim.lsp.inline_completion.get() then
      return
    end

    if nes.have() then
      nes.jump()
      nes.apply()
    end
  end)

  Snacks.toggle
    .new({
      id = "diff_windows",
      name = "Diff Windows",
      get = function()
        return vim.wo.diff
      end,
      set = function(state)
        if not state then
          return vim.cmd("diffoff!")
        end
        -- Only listed buffers in normal windows, so explorers and floats stay out of the diff
        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
          local buf = vim.api.nvim_win_get_buf(win)
          if vim.bo[buf].buflisted and vim.api.nvim_win_get_config(win).relative == "" then
            vim.api.nvim_win_call(win, function()
              vim.cmd("diffthis")
            end)
          end
        end
      end,
    })
    :map("<leader>fd")
end
