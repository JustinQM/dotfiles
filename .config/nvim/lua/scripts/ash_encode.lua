local M = {}
local groups = {
    "aeiouy",
    "ghkqrx",
    "bfmpvw",
    "cdjlnstz"
}

local keys = {}
function M.vim_encode()

	--generate keys
	--TODO: find way to keep keys around to reverse?
    for k, v in pairs(groups) do
        keys[k] = math.random(#v - 1)
	end


	--get current mode
	local mode = vim.api.nvim_get_mode().mode

	--NORMAL MODE
	if mode == 'n' then
		local cursor = vim.api.nvim_win_get_cursor(0)
		local line_num = cursor[1]
		local line = vim.fn.getline(line_num,line_num)
		-- local k,v = pairs(line)??
		for k,v in pairs(line) do
			line[k] = M.encode(v)
		end
		vim.api.nvim_buf_set_lines(0, line_num-1, line_num, true, line)
		return
	end

	--VISUAL MODE
	--escape visual mode so the markers ('< and '>) are updated
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', false, true, true), 'nx', false)

	local vstart = vim.fn.getpos("'<")
	local vend = vim.fn.getpos("'>")

	local vstart_line = vstart[2]
	local vstart_col = vstart[3]

	local vend_line = vend[2]
	local vend_col = vend[3]

	local total_lines = vend_line - vstart_line + 1

	-- or use api.nvim_buf_get_lines
	local lines = vim.fn.getline(vstart_line,vend_line)
	for k,v in pairs(lines) do
		if k == 1 then --first line
			--TODO: Don't do this?
			local slice_ending = string.len(v)
			if total_lines == 1 then
				slice_ending = vend_col	
			end
			--end of dumb
			local slice = string.sub(v, vstart_col,slice_ending)
			slice = M.encode(slice)
			v = string.sub(v,0,vstart_col-1) .. slice .. string.sub(v,vstart_col + string.len(slice))
		elseif k == total_lines then --last line in selection
			local slice = string.sub(v, 1, vend_col)
			slice = M.encode(slice)
			if 2^31-1 == vend_col then
				v = slice	
			else --slice has other text that needs to be added
				v = slice .. string.sub(v,vend_col+1)
			end
		else --in the middle
			v = M.encode(v)
		end
		lines[k] = v
	end

	vim.api.nvim_buf_set_lines(0, vstart_line - 1, vend_line, true, lines)
end

function M.encode(x)

    return ({x:gsub("%a", function(orig)
        
        local upper = orig:byte() <= 90
        local char = orig:lower()
        local byte = char:byte()

        for k, letters in pairs(groups) do

            local len = #letters
            local idx = letters:find(char)
            if idx then

                local key = keys[k]
                idx = ((idx - 1 + key) % len) + 1
                char = letters:sub(idx, idx)
                return upper and char:upper() or char

            end

        end
        return orig

    end)})[1]
end
return M
