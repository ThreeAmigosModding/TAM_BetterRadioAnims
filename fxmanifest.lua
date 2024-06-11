--[[------------------------------------------------------
----       For Support - discord.gg/threeamigos       ----
---- Do not edit if you do not know what you"re doing ----
--]]------------------------------------------------------

game "gta5"
lua54 "yes"
fx_version "cerulean"
use_experimental_fxv2_oal "yes"

author "Marfia Studios"
version "1.0.0"
license "GPL-v3"
name "RadioAnimationCommand"
description "Three Amigos Modding - Better Radio Animations | Marfia Studios Radio Animation Command"

client_debug_mode "false"
server_debug_mode "false"
experimental_features_enabled "0"

dependencies {
	"ox_lib",
}

shared_scripts {
	"@ox_lib/init.lua"
}

client_script "client/main.lua"

escrow_ignore {
	"client/*.lua",
	"stream/*",
	"server/*.lua"
}
