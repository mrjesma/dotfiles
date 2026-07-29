--- [[ Setting globals ]] ------------------------------------------------------

-- Enable faster startup by caching compiled Lua modules
vim.loader.enable()

-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

--- [[ Setting options ]] ------------------------------------------------------
-- See `:help option-list` and `:help <opt>`

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Mouse support
vim.opt.mouse = 'r'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim
vim.schedule(function() vim.o.clipboard = 'unnamedplus' end)

-- Enable beak indent (long wrapped lines indentation)
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or on or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default (left column that shows signs)
vim.opt.signcolumn = 'yes'

-- Decease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Sets how certain whitespaces characters will be displayed
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Highlight current line
vim.opt.cursorline = true

-- Highlight column
-- vim.opt.colorcolumn = '80'

-- Minimal number of screen lines to keep above and below the cursor
vim.opt.scrolloff = 10

--- [[ Basic keymaps ]] --------------------------------------------------------

-- Clear search highlights when pressing <Esc> in normala mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Exit terminal mode when pressing <Esc>
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

--- [[ Basic autocommands ]] ---------------------------------------------------

-- Highlight when yanking text
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking text',
	group = vim.api.nvim_create_augroup('kickstart-highlight-yank', {clear = true}),
	callback = function()
		vim.highlight.on_yank()
	end,
})

---- [[ Setup vim.pack plugin manager ]] ---------------------------------------

-- This autocommand runs after a plugin is installed or updated and
--  runs the appropriate build command for that plugin if necessary.
local function run_build(name, cmd, cwd)
	local result = vim.system(cmd, { cwd = cwd }):wait()
	if result.code ~= 0 then
		local stderr = result.stderr or ''
		local stdout = result.stdout or ''
		local output = stderr ~= '' and stderr or stdout
		if output == '' then output = 'No output from build command.' end
		vim.notify(('Build failed for %s:\n%s'):format(name, output), vim.log.levels.ERROR)
	end
end
vim.api.nvim_create_autocmd('PackChanged', {
	callback = function(ev)
		local name = ev.data.spec.name
		local kind = ev.data.kind
		if kind ~= 'install' and kind ~= 'update' then return end

		if name == 'telescope-fzf-native.nvim' and vim.fn.executable 'make' == 1 then
			run_build(name, { 'make' }, ev.data.path)
			return
		end

		if name == 'LuaSnip' then
			if vim.fn.has 'win32' ~= 1 and vim.fn.executable 'make' == 1 then run_build(name, { 'make', 'install_jsregexp' }, ev.data.path) end
			return
		end

		if name == 'nvim-treesitter' then
			if not ev.data.active then vim.cmd.packadd 'nvim-treesitter' end
			vim.cmd 'TSUpdate'
			return
		end
	end,
})

-- Iterate over all Lua files in the plugins directory and load them
local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'plugins')
for file_name, type in vim.fs.dir(plugins_dir) do
	if type == 'file' and file_name:match '%.lua$' then
		local module = file_name:gsub('%.lua$', '')
		require('plugins.' .. module)
	end
end

