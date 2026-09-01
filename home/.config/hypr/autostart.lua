-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:

local james = hl    -- :D

 james.on("hyprland.start", function () 
   james.exec_cmd("vj-launch-terminal")
   james.exec_cmd("nm-applet")
   james.exec_cmd("waybar & hyprpaper")
   james.exec_cmd("hyprlock")
 end)
