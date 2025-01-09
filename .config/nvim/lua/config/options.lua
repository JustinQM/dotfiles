local opt = vim.opt

-- [[ Context ]]
--opt.colorcolumn = '80'           -- str:  Show col for max line length
opt.relativenumber = true        -- bool: Show relative line numbers
opt.number = true                --bool: Show exact line number on current line
opt.scrolloff = 4                -- int:  Min num lines of context
opt.signcolumn = "no"           -- str:  Show the sign column

-- [[ Filetypes ]]
opt.encoding = 'utf8'            -- str:  String encoding to use
opt.fileencoding = 'utf8'        -- str:  File encoding to use

-- [[ Theme ]]
opt.syntax = "ON"                       -- str:  Allow syntax highlighting
opt.termguicolors = true                -- bool: If term supports ui color then enable
vim.api.nvim_command('set cmdheight=1') -- forces status bar to be 1 character tall
vim.api.nvim_command('set conceallevel=2')
opt.showmode = false                    -- disables showmode to reduce redundant messages

-- [[ Search ]]
opt.ignorecase = true            -- bool: Ignore case in search patterns
opt.smartcase = true             -- bool: Override ignorecase if search contains capitals
opt.incsearch = true             -- bool: Use incremental search
opt.hlsearch = false             -- bool: Highlight search matches

-- [[ Whitespace ]]
opt.expandtab = false            -- bool: Use spaces instead of tabs
opt.shiftwidth = 4               -- num:  Size of an indent
opt.softtabstop = 4              -- num:  Number of spaces tabs count for in insert mode
opt.tabstop = 4                  -- num:  Number of spaces tabs count for

-- [[ Splits ]]
opt.splitright = true            -- bool: Place new window to right of current one
opt.splitbelow = true            -- bool: Place new window below the current one

-- [[General Settings]]
vim.g["surround_no_mappings"] = 1
vim.cmd([[set clipboard=unnamedplus]])
vim.cmd([[set timeoutlen=500]])  -- sets timeout of commands
vim.cmd([[colorscheme monokai-pro]])
vim.cmd([[hi LineNr guibg=none guifg=#ff7185]]) --sets relative line numbers background to transparent
-- vim.cmd([[hi LineNr guibg=none guifg=#fd915d]]) --sets relative line numbers background to transparent

-- [[Diagnostic LSP Settings]]

--disabled LOL
vim.diagnostic.disable()
--[[
vim.diagnostic.config({
	--only show virtual text on errors
	virtual_text = {
		severity = { min = vim.diagnostic.severity.ERROR }
	},
	--underline warnings
	underline = {
		severity = {  min = vim.diagnostic.severity.WARN }
	},
	virtual_lines = false,
	signs = true,
})
--]]


-- [[Todo Highlights]]
vim.fn.matchadd("DiagnosticInfo", "\\(TODO:\\)")
vim.fn.matchadd("DiagnosticHint", "\\(NOTE:\\)")
vim.fn.matchadd("DiagnosticWarn", "\\(WARN:\\)")
vim.fn.matchadd("DiagnosticWarn", "\\(WARNING:\\)")
vim.fn.matchadd("DiagnosticWarn", "\\(HACK:\\)")
vim.fn.matchadd("DiagnosticError", "\\(FIX:\\)")

-- [[File Types]]
vim.filetype.add({
  extension = {
    c3 = "c3",
    c3i = "c3",
    c3t = "c3",
  },
})
