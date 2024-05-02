--[[------------------------------------------------------
----       For Support - discord.gg/threeamigos       ----
---- Do not edit if you do not know what you"re doing ----
--]]------------------------------------------------------
local config = require 'data.config'

if not config or not lib then return end

local scully = lib.checkDependency("scully_emotemenu", "1.8.0")
local rpemotes = lib.checkDependency("rpemotes", "1.3.8")
local rpradio = lib.checkDependency("rp-radio", "1.0.0")

lib.print.info("-----------------------------------------------")
if scully and not rpemotes then
    lib.print.info("Successfully loaded TAM_BetterRadioAnims")
    lib.print.info("Successfully loaded scully_emotemenu integration!")
elseif not scully and rpemotes then
    lib.print.info("Successfully loaded TAM_BetterRadioAnims")
    lib.print.info("Successfully loaded rpemotes integration!")
else
    lib.print.info("Loading TAM_BetterRadioAnims Failed!")
    lib.print.error("rpemotes or scully_emotemenu is either outdated or missing or both installed. Please update and make sure you only have one of the resources installed and running.")
end

if rpradio then
    lib.print.error("rp-radio is NOT compatible with this resource and this resource will NOT work with it. Please remove it to use this resource.")
end

if config.debug then
    lib.print.info("Debug mode is enabled!")
end

lib.print.info("Join our Discord for support: discord.gg/threeamigos")
lib.print.info("Documentation: docs.threeamigos.shop")
lib.print.info("-----------------------------------------------")
lib.versionCheck("ThreeAmigosModding/TAM_BetterRadioAnims")
