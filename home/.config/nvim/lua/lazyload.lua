local M = {}

local vim_enter_queue = {}
local override_queue = {}

local function process(input)
	if not input then return end

	local queue = vim.islist(input) and input or { input }

	for _, entry in ipairs(queue) do
		if entry.sync then
			entry.fn()
		else
			vim.schedule(entry.fn)
		end
	end
end

local function process_override(input)
	input = input or override_queue
	if not input then return end

	local queue = vim.islist(input) and input or { input }

	for _, entry in ipairs(override_queue) do
		vim.schedule(function()
			local ok, err = pcall(entry.fn)
			if not ok then
				vim.notify(("Override Error:\n%s"):format(err), vim.log.levels.ERROR)
			end
		end)
	end
	
	if input == override_queue then
		override_queue = nil
	end
end

vim.api.nvim_create_autocmd("VimEnter", {
	once = true,
	callback = function()
		process(vim_enter_queue)
		vim_enter_queue = nil
		process_override()
	end,
})

function M.on_vim_enter(fn, opts)
	local entry = { fn = fn, sync = opts and opts.sync or false }

	if vim_enter_queue then
		table.insert(vim_enter_queue, entry)
	else
		process(entry)
	end
end

function M.on_override(fn)
	local entry = { fn = fn }
	
	if override_queue then
		table.insert(override_queue, entry)
	else
		process_override(entry)
	end
end

return M
