-- J: This is the example config! As You can see, it is located in ~/.config/hypr/hyprland.lua :>
-- J: Most of our configs will exist with in .config/ (See https://wiki.archlinux.org/title/XDG_Base_Directory for more details)
-- J: I put this here as an example of the filesystem hierarchy itself, but feel free to check this file for an example config for Hyprland! (You should actually hehe)
-- J: Ask me anything, change anything and see how it works! Unfortunately, as of now, we do not have any ways to connect this to our systems. So you'd need to copy this to your ACTUAL .config/, it can be done with `cp`! (Any tutorials should do, but ask me if you wanna :>)
-- J: You can do thisss :D

require("envs")
require("monitors")
require("window")
require("input")
require("binds")
require("autostart")
require("looknfeel")

---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "wofi --show drun"




-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")




-- With all the love in the world, J <3
