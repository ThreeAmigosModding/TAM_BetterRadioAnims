--[[------------------------------------------------------
----       For Support - discord.gg/threeamigos       ----
---- Do not edit if you do not know what you"re doing ----
--]]------------------------------------------------------

local scully = lib.checkDependency("scully_emotemenu", "1.8.0")
local rpemotes = lib.checkDependency("rpemotes", "1.3.8")
local config = require "data.config"
local export = nil

if scully and not rpemotes then 
    export = exports["scully_emotemenu"]
elseif not scully and rpemotes then
    export = exports["rpemotes"]
else
    lib.print.debug("rpemotes or scully_emotemenu is either outdated or missing or both installed. Please update and make sure you only have one of the resources installed and running.")
end

local function handleEmote(emote, action)
    if scully and not rpemotes then
        if action == "play" then
            export:playEmoteByCommand(emote)
        elseif action == "stop" then
            export:cancelEmote()
        end
    elseif rpemotes and not scully then
        if action == "play" then
            export:EmoteCommandStart(emote)
        elseif action == "stop" then
            export:EmoteCancle()
        end
    end
end

local function checkType(ped, animType)
    local modelTypes = {
        male = GetHashKey("mp_m_freemode_01"),
        female = GetHashKey("mp_f_freemode_01")
    }
    
    local mode = GetEntityModel(ped)
    local animConfig = config[animtype]

    if animConfig and animConfig.enable then
        local drawableType = GetPedDrawableVariation(ped, animConfig.drawable)
        local textureType = GetPedTextureVariation(ped, drawableType)

        for gender, modelType in pairs(modelTypes) do
            if model == modelType then
                for _, variation in pairs(animconfig[gender]) do
                    for _, texture in pairs(animConfig[gender .. "Texture"]) do
                        if drawableType == variation and textureType == texture then return true end
                    end
                end
            end
        end
    end

    if lib.table.contains(config.blacklistedPeds, model) then
        TriggerEvent("chat:addMessage", "That model is blacklisted!")
        if config.debug then lib.print.debug("That model is blacklisted!") end
        return "blacklisted"
    else
        if config.debug then lib.print.debug("Unspecified drawable, reverting to default animation.") end
        return false
    end
end

AddEventHandler("pma-voice:radioActive", function(radioTalking)
    local ped = cache.ped
    local playerId = cache.playerId
    local veh = cache.vehicle
    local aiming = IsPlayerFreeAiming(playerId)
    local vehClass = GetVehicleClass(veh)

    if not DoesEntityExist(ped) or IsEntityDead(ped) or IsPauseMenuActive() then return end

    if radioTalking then
        local emote = config.defaultEmote

        if checkType(ped, "chest") then
            emote = config.chestAnim.emote
        elseif checkType(ped, "shoulder") and not aiming then
            emote = config.shoulderAnim.emote
        elseif checkType(ped, "shoulder") and aiming then
            emote = config.shoulderAnim.emoteAiming
        elseif checkType(ped, "ear") then
            emote = config.earpieceAnim.emote
        elseif veh and checkType(ped, "ear") and not lib.table.contains(config.blacklistedClasses, vehClass) then
            emote = config.earpieceAnim.emote
        end

        handleEmote(emote, "play")
    elseif not radioTalking then
        handleEmote(nil, "stop")
    elseif config.debug then
        lib.print.debug("Unknown Error with event handler pma-voice:radioActive")
    end
end)

if config.debug then
    lib.print.info("Debug mode is enabled.")

    RegisterCommand("getdrawable", function(args)
        if tonumber(args[1]) == nil then 
            TriggerEvent("chat:addMessage", "Invalid Usage. Usage: /getdrawable <0-11>")
            return
        end
        local ped = cache.ped
        local componentId = args[1]
        local drawableType = GetPedDrawableVariation(ped, componentId)

        lib.print.info("Copied ".. drawableType .. " to your clipboard!")
        TriggerEvent("chat:addMessage", "Copied ".. drawableType .. " to your clipboard!")
        lib.setCilpboard(drawableType)
    end, false)

    RegisterCommand("gettexture", function(args)
        if tonumber(args[1]) == nil then 
            TriggerEvent("chat:addMessage", "Invalid Usage. Usage: /gettexture <0-11>")
            return
        end
        local ped = cache.ped
        local componentId = args[1]
        local drawableType = GetPedDrawableVariation(ped, componentId)
        local textureType = GetPedTextureVariation(ped, drawableType)

        lib.print.info("Copied ".. textureType .. " to your clipboard!")
        TriggerEvent("chat:addMessage", "Copied ".. textureType .. " to your clipboard!")
        lib.setCilpboard(textureType)
    end, false)
    
    RegisterCommand("setradiochannel", function()
        exports["pma-voice"]:setRadioChannel(1)
    end, false)
end