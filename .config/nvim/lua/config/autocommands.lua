--enable highlighting for ssa files (qbe IL)
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
	pattern = {"*.ssa"},
	callback = function()
	vim.opt.syntax = "ruby"
	end,
})


--start godot server if directory has project.godot
vim.api.nvim_create_autocmd({"VimEnter", "DirChanged"}, {
  group = vim.api.nvim_create_augroup("GodotPipeManager", { clear = true }),
  callback = function()
    -- Check if we're in a Godot project
    local is_godot_project = vim.fn.filereadable("project.godot") == 1
    
    -- Get list of active servers as a Lua table
    local active_servers = vim.fn.serverlist()
    
    -- Check if our specific server exists in the table
    local server_exists = vim.tbl_contains(active_servers, "/tmp/godothost")

    if is_godot_project and not server_exists then
      vim.fn.serverstart("/tmp/godothost")
      vim.notify("Godot pipe server started: /tmp/godothost", vim.log.levels.INFO)
    elseif not is_godot_project and server_exists then
      vim.fn.serverstop("/tmp/godothost")
      vim.notify("Godot pipe server stopped", vim.log.levels.INFO)
    end
  end,
})
