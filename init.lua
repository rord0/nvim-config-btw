-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader      = " "
vim.g.maplocalleader = "\\"

require("config.lazy")
require("config.neovide")

vim.g.have_nerd_font = true		-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.o.number	  = true		-- Make line numbers default
vim.o.relativenumber = true		-- Enable relative line numbers
vim.o.mouse		  = 'a'			-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.clipboard   = 'unnamedplus'	-- Sync clipboard between OS and NeoVim
vim.o.confirm 	  = true		-- raise dialog if performing an operation that would fail due to unsaved changes in the buffer
vim.o.scrolloff   = 10			-- Minimal number of screen lines to keep above and below the cursor.
vim.o.breakindent = true		-- Enable break indent
vim.o.undofile    = true		-- Save undo history
vim.o.ignorecase  = true		-- Enable case-insensitive searching
vim.o.smartcase   = true		-- Allow case-sensitive searching when one or more capital letters are in the search term
vim.o.showmode    = false		-- Don't show the mode 

vim.opt.tabstop	   = 4
vim.opt.shiftwidth = 4

vim.o.splitright  = true -- Configure how new splits should be opened
vim.o.inccommand  = 'split'		-- Preview substitutions live!


vim.keymap.set("n", "<leader>t", function()
    require("neo-tree.command").execute({ toggle = true })
end, { desc = "Toggle Neo-tree" })

vim.keymap.set("n", "<leader>b", ":!.\\build.bat<cr>", { desc = "run build.bat" })

vim.keymap.set("n", "<leader>r", function()
  local build_dir = vim.fn.getcwd() .. "/build"
  local exes = vim.fn.glob(build_dir .. "/*.exe", false, true)

  if #exes == 0 then
    vim.notify("No .exe found in " .. build_dir, vim.log.levels.ERROR)
    return
  end

  local exe_name = vim.fn.fnamemodify(exes[1], ":t")

  vim.fn.system({
    "cmd.exe", "/c", "cd", "/d", "build", "&&", "start", "",
    "raddbg", "./" .. exe_name, "--auto_run"
  })
end, { desc = "Run raddebugger in terminal" })

vim.filetype.add({
    extension = {
        hlsl = "hlsl",
    }
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "hlsl",
    callback = function()
        vim.treesitter.start()
    end
})

-- Map tab to accept first blink.cmp snippet
vim.keymap.set("i", "<Tab>", function()
  local ok, cmp = pcall(require, "blink.cmp")
  if ok and cmp.is_visible() then
    return cmp.accept()
  end

  return "\t"
end, { expr = true })

require("lazy").setup("plugins")
