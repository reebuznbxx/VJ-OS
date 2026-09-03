local vamp = require("helpers") -- An excuse to say your name!

local fileManager = "dolphin"
local menu        = "walker"

local mainMod = "SUPER"

vamp.bind(mainMod .. " + Q", { vj = "terminal" })
local closeWindowBind = vamp.bind(mainMod .. " + ESCAPE", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)
vamp.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
vamp.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
vamp.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
vamp.bind(mainMod .. " + R", { vj = menu })
vamp.bind(mainMod .. " + P", hl.dsp.window.pseudo())
vamp.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only


--need ss :>
vamp.bind("Print", hl.dsp.exec_cmd("hyprshot -m output -o clipboard"))
vamp.bind(mainMod .. " + Print", hl.dsp.exec_cmd("hyprshot -m region -o clipboard"))




-- Move focus with mainMod + arrow keys
vamp.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
vamp.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
vamp.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
vamp.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

vamp.bind(mainMod .. " + TAB", function()
	local layouts = { "dwindle", "scrolling" }
	local ws = hl.get_active_special_workspace() or hl.get_active_workspace() -- First value is used if true!
	if not ws then return end

	local curr_layout = ws.tiled_layout
	local next_layout = layouts[vamp.get_index(layouts, curr_layout) % #layouts + 1]
	if not next_layout then return end
	
	local ws_info = tostring(ws.name or ws.id)
	hl.workspace_rule({
		workspace = ws_info,
		layout = next_layout
	})

	hl.notification.create({
		text = "[LAYOUT] Switched workspace " .. ws_info .. " from " .. curr_layout .. " to " .. next_layout,
		timeout = 3000,
		icon = "OK"
	})
end)

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    vamp.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    vamp.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Example special workspace (scratchpad)
vamp.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
vamp.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
vamp.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
vamp.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
vamp.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
vamp.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Laptop multimedia keys for volume and LCD brightness
vamp.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
vamp.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
vamp.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
vamp.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
vamp.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
vamp.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

-- Requires playerctl
vamp.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
vamp.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
vamp.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
vamp.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

vamp.bind(mainMod .. " + CTRL + Z", function()
	local zoom = hl.get_config("cursor.zoom_factor") or 1
	hl.config({ cursor = { zoom_factor = zoom + 1 } })
end)

vamp.bind(mainMod .. " + CTRL + ALT + Z", function()
	hl.config({ cursor = { zoom_factor = 1 } })
end)
