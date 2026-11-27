-- [[ Setting options ]]
-- See `:help option-list`. One line per option; the value is the one in use.

-- Line numbers
vim.o.number = true
vim.o.relativenumber = true
vim.o.numberwidth = 4
vim.o.signcolumn = "yes"
vim.o.colorcolumn = "80"
vim.o.cursorline = false

-- Mouse, status and tab lines
vim.o.mouse = "a"
vim.o.showmode = false -- the mode is already in the status line
vim.o.showtabline = 2
vim.o.cmdheight = 1
vim.o.termguicolors = true

-- Sync clipboard between OS and Neovim.
--  Scheduled after `UiEnter` because it can increase startup time.
vim.schedule(function()
	vim.o.clipboard = "unnamedplus"
end)

-- Long lines: no wrapping; if wrap is turned on, break at words with indent
vim.o.wrap = false
vim.o.linebreak = true
vim.o.breakindent = true
vim.o.whichwrap = "bs<>[]hl" -- these keys move to the previous/next line

-- Indentation: 4 spaces (vim-sleuth adjusts it per file)
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.backspace = "indent,eol,start"

-- Search: case-insensitive unless \C or a capital letter; no highlight after search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = false
vim.o.inccommand = "split" -- preview substitutions live

-- Scrolling and splits
vim.o.scrolloff = 4
vim.o.sidescrolloff = 8
vim.o.splitright = true
vim.o.splitbelow = true

-- Show tabs, trailing spaces and non-breaking spaces
vim.o.list = true
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.o.conceallevel = 0 -- markdown files set 2 in autocommands.lua

-- Files: undo history on disk, no swap or backup files
vim.o.undofile = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.writebackup = false
vim.o.fileencoding = "utf-8"

-- Timing
vim.o.updatetime = 250
vim.o.timeoutlen = 300 -- wait for a mapped sequence

-- Completion menu
vim.o.completeopt = "menuone,noselect"
vim.o.pumheight = 10
vim.opt.shortmess:append("c") -- no ins-completion-menu messages

-- Treat hyphenated-words as one word
vim.opt.iskeyword:append("-")

-- Don't continue comments on <Enter>, o/O or auto-wrap
vim.opt.formatoptions:remove({ "c", "r", "o" })
