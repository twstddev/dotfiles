-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set
local del = vim.keymap.del

map({ "n", "v", "x", "i" }, "<C-c>", "<Esc>")

del("n", "<S-h>")
del("n", "<S-l>")
del({ "i", "x", "n", "s" }, "<C-s>")

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
  map({ "n", "i", "x" }, "<A-;>", function()
    local nes = require("sidekick.nes")
    local suggestion = require("copilot.suggestion")

    if suggestion.is_visible() then
      LazyVim.create_undo()
      suggestion.accept()
      -- This is a temporary hack to make sure that in typescript files copilot suggestions appear more than one line at a time.
      suggestion.accept()
    end

    if nes.have() then
      nes.jump()
      nes.apply()
    end
  end)
end
