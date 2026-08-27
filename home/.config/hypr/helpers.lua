local M = {}

local function shell_quote(v)
	return "'" .. tostring(v):gsub("'", "'\\''") .. "'"
end

function M.bind(keys, dispatcher, options)
	local opts = options or {}
	
	if type(dispatcher) == "table" then
		local focus = dispatcher.focus and " -f" or ""
		
		if dispatcher.vj then
			dispatcher = "vj-launch-" .. dispatcher.vj
		elseif dispatcher.gui then
			dispatcher = "vj-launch" .. focus .. " " .. shell_quote(dispatcher.gui)
		elseif dispatcher.tui then
			dispatcher = "vj-launch-tui" .. focus .. " " .. shell_quote(dispatcher.tui)
		else
			hl.notification.create({
				text = "[LAUNCH] Application not found :<",
				timeout = 3000,
    		})
			dispatcher = ""
		end

		dispatcher = hl.dsp.exec_cmd(dispatcher)
	end

	hl.bind(keys, dispatcher, opts)
end

return M
