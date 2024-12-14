--commented out for now since I am not using obsidian
return {
	"epwalsh/obsidian.nvim",
	version = "*",  -- recommended, use latest release instead of latest commit
	lazy = false,
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-telescope/telescope.nvim",
		"hrsh7th/nvim-cmp",
	},
	--keybinds
	init = function()
		vim.keymap.set('n', '<leader>on', ':ObsidianNew<CR>')
		vim.keymap.set('n', '<leader>oo', '<CMD>ObsidianOpen<CR>')
		vim.keymap.set({'n','v'}, '<leader>oe', ':ObsidianExtractNote<CR>')
		vim.keymap.set('n', '<leader>odd', '<CMD>ObsidianToday<CR>')
		vim.keymap.set('n', '<leader>ody', '<CMD>ObsidianYesterday<CR>')
		vim.keymap.set('n', '<leader>odt', '<CMD>ObsidianTomorrow<CR>')
		vim.keymap.set('n', '<leader>off', '<CMD>ObsidianQuickSwitch<CR>')
		vim.keymap.set('n', '<leader>ofg', '<CMD>ObsidianSearch<CR>')
		vim.keymap.set('n', '<leader>oft', '<CMD>ObsidianTags<CR>')
		vim.keymap.set('n', '<leader>ofd', '<CMD>ObsidianDailies -3 3<CR>')
		vim.keymap.set('n', '<leader>ofl', '<CMD>ObsidianLinks<CR>')
		vim.keymap.set('n', '<leader>ofr', '<CMD>ObsidianBacklinks<CR>')
	end,

	opts = {
		workspaces = {
			{
				name = "vault",
				path = "~/vault",
				overrides = {
					notes_subdir = "inbox",
				},
			},
		},
		new_notes_location = "inbox",

		daily_notes = {
			-- Optional, if you keep daily notes in a separate directory.
			folder = "daily",
			-- Optional, if you want to change the date format for the ID of daily notes.
			date_format = "%m-%d-%Y",
			-- Optional, if you want to change the date format of the default alias of daily notes.
			alias_format = "%B %-d, %Y",
			-- Optional, if you want to automatically insert a template from your template directory like 'daily.md'
			template = nil
		},
		completion = {
			-- Set to false to disable completion.
			nvim_cmp = true,
			-- Trigger completion at 2 chars.
			min_chars = 2,
		},
		picker = {
			-- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
			name = "telescope.nvim",
			-- Optional, configure key mappings for the picker. These are the defaults.
			-- Not all pickers support all mappings.
			mappings = {
			-- Create a new note from your query.
			new = "<C-x>",
			-- Insert a link to the selected note.
			insert_link = "<C-l>",
			},
		},
		-- Optional, customize how note IDs are generated given an optional title.
		---@param title string|?
		---@return string
		note_id_func = function(title)
			-- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
			-- In this case a note with the title 'My new note' will be given an ID that looks
			-- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
			local suffix = ""
			if title ~= nil then
				-- If title is given, transform it into valid file name.
				suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
			else
				-- If title is nil, just add 4 random uppercase letters to the suffix.
				for _ = 1, 4 do
					suffix = suffix .. string.char(math.random(65, 90))
				end
			end
			return tostring(suffix .. "-" .. os.time())
		end,
	},
} 
