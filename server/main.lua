--[[------------------------------------------------------
----       For Support - discord.gg/threeamigos       ----
---- Do not edit if you do not know what you"re doing ----
--]]------------------------------------------------------

lib.versionCheck("ThreeAmigosModding/TAM_BetterRadioAnims")

local scully = lib.checkDependency("scully_emotemenu", "1.8.0")
local rpemotes = lib.checkDependency("rpemotes", "1.3.8")
local rpradio = lib.checkDependency("rp-radio", "1.0.0")

if scully and not rpemotes then 
    lib.print.info("Successfully loaded scully_emotemenu integration!")
    lib.print.info("Join our Discord for support: discord.gg/threeamigos")
    lib.print.info("Documentation: docs.threeamigos.shop")
elseif not scully and rpemotes then
    lib.print.info("Successfully loaded rpemotes integration!")
    lib.print.info("Join our Discord for support: discord.gg/threeamigos")
    lib.print.info("Documentation: docs.threeamigos.shop")
else
    lib.print.error("rpemotes or scully_emotemenu is either outdated or missing or both installed. Please update and make sure you only have one of the resources installed and running.")
    lib.print.info("Join our Discord for support: discord.gg/threeamigos")
    lib.print.info("Documentation: docs.threeamigos.shop")
end

if rpradio then 
    lib.print.error("rp-radio is NOT compatible with this resource and this resource will NOT work with it. Please remove it to use this resource.")
    lib.print.info("Join our Discord for support: discord.gg/threeamigos")
    lib.print.info("Documentation: docs.threeamigos.shop")
end

if config.debug then
    lib.print.info("Debug mode is enabled!")
end