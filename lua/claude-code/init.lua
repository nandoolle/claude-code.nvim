local M = {}
local terminal_buf = nil
local terminal_win = nil
local is_open = false

local function create_floating_window()
	local width = math.floor(vim.o.columns * 0.8)
	local height = math.floor(vim.o.lines * 0.8)
	local row = math.floor((vim.o.lines - height) / 2)
	local col = math.floor((vim.o.columns - width) / 2)

	local opts = {
		relative = "editor",
		width = width,
		height = height,
		row = row,
		col = col,
		style = "minimal",
		border = "rounded",
	}

	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, opts)

	vim.api.nvim_win_set_option(win, "winhl", "Normal:Normal")
	vim.api.nvim_buf_set_option(buf, "filetype", "terminal")

	return buf, win
end

function M.toggle()
	if is_open and terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
		vim.api.nvim_win_close(terminal_win, true)
		is_open = false
	else
		if not terminal_buf or not vim.api.nvim_buf_is_valid(terminal_buf) then
			terminal_buf, terminal_win = create_floating_window()
			vim.fn.termopen("claude", {
				on_exit = function()
					terminal_buf = nil
					terminal_win = nil
					is_open = false
				end,
			})
			vim.cmd("startinsert")
		else
			_, terminal_win = create_floating_window()
			vim.api.nvim_win_set_buf(terminal_win, terminal_buf)
			vim.cmd("startinsert")
		end
		is_open = true

		vim.api.nvim_create_autocmd("WinLeave", {
			callback = function()
				if vim.api.nvim_get_current_win() == terminal_win then
					return
				end
				if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
					vim.api.nvim_win_close(terminal_win, false)
					is_open = false
				end
			end,
			once = true,
		})
	end
end

function M.setup(opts)
	opts = opts or {}
	
	local default_opts = {
		keybinding = "<localleader>cc"
	}
	
	opts = vim.tbl_extend("force", default_opts, opts)

	vim.api.nvim_create_user_command("ClaudeCode", function()
		M.toggle()
	end, {})

	if opts.keybinding then
		vim.keymap.set("n", opts.keybinding, M.toggle, { desc = "Toggle Claude Code" })
	end
end

return M

