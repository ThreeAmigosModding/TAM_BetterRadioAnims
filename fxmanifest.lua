--[[------------------------------------------------------
----       For Support - discord.gg/threeamigos       ----
---- Do not edit if you do not know what you"re doing ----
--]]------------------------------------------------------

game "gta5"
lua54 "yes"
fx_version "cerulean"
use_experimental_fxv2_oal "yes"

author "Hakko"
version "3.0.0"
license "GPL-v3"
name "TAM_BetterRadioAnims"
description "Three Amigos Modding - Better Radio Animations"
repository "https://github.com/threeamigosmodding/TAM_BetterRadioAnims"

client_debug_mode "false"
server_debug_mode "false"
experimental_features_enabled "0"

dependencies {
	"ox_lib",
}

shared_scripts {
	"@ox_lib/init.lua",
    "data/**"
}

client_script "client/main.lua"

server_script "server/main.lua"