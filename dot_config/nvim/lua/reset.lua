vim.diagnostic.config({ virtual_text = true })

vim.opt.showmode = true
vim.opt.guicursor = ""
vim.opt.termguicolors = true

vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.colorcolumn = "80"
vim.opt.scrolloff = 8      -- Minimal number of screen lines to keep above and below the cursor
vim.opt.splitbelow = true  -- force all horizontal splits to go below current window
vim.opt.splitright = true  -- force all vertical splits to go to the right of current window

vim.opt.hlsearch = true   -- highlight all matches on previous search pattern
vim.opt.ignorecase = true -- ignore case in search patterns
vim.opt.smartcase = true  -- case insensitive unless capitals used in search
vim.opt.wildmenu = true   -- on TAB, complete options for system command
vim.opt.wildignore = vim.opt.wildignore + { '*/node_modules/*', '*/.git/*', '*/vendor/*' }

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' } -- Set completeopt to have a better completion experience
vim.opt.shortmess = vim.opt.shortmess + { c = true }

vim.opt.smartindent = true
vim.opt.expandtab = true   -- convert tabs to spaces
vim.opt.shiftwidth = 4     -- the number of spaces inserted for each indentation
vim.opt.tabstop = 4        -- insert 4 spaces for a tab
vim.opt.softtabstop = 4    -- insert 4 spaces for a tab

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath "cache" .. "/undo"
vim.opt.directory = '~/.config/nvim/swap//,/tmp//'
vim.opt.formatoptions:remove({ 'c', 'r', 'o' }) -- dont take effect. using autocmd...
vim.opt.whichwrap:remove({ 'h', 'l' })
vim.opt.foldmethod = "expr"			-- treesitter based folding
vim.opt.foldexpr = "nvim_treesitter#foldexpr()" -- treesitter based folding
vim.o.foldenable = false
vim.opt.spell = false
vim.opt.spelllang = "en"

vim.opt.fileencoding = "utf-8"    -- the encoding written to a file
vim.opt.encoding = "utf-8"        -- the encoding displayed

vim.opt.lazyredraw = true  -- screen will not be redrawn while executing macros, registers and other commands that have not been typed
vim.opt.redrawtime = 1500  -- time in milliseconds for redrawing the display
vim.opt.timeoutlen = 500   -- time to wait for a mapped sequence to complete (in milliseconds)
vim.opt.ttimeoutlen = 10   -- time in milliseconds to wait for a key code sequence to complete
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 100

vim.opt.hidden = true
vim.opt.conceallevel = 0 -- so that ``` is visible in MD files

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_liststyle = 0
vim.g.netrw_showhide = 1
vim.g.netrw_winsize = 25
