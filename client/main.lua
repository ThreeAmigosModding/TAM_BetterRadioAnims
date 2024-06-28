--[[------------------------------------------------------
----       For Support - discord.gg/threeamigos       ----
---- Do not edit if you do not know what you"re doing ----
--]]------------------------------------------------------
local config = require "data.config"

if not lib or not config then return end

local scully = lib.checkDependency("scully_emotemenu", "1.8.0")
local rpemotes = lib.checkDependency("rpemotes", "1.3.8")
local export = nil

if scully then
    export = exports["scully_emotemenu"]
elseif rpemotes then
    export = exports["rpemotes"]
else
    return lib.print.debug("rpemotes or scully_emotemenu is either outdated or missing or both installed. Please update and make sure you only have one of the resources installed and running.")
end

--- Function to handle emote playing
---@param emote? string
---@param action? string
local function handleEmote(emote, action)
    if not export then return end

    if scully and action == "play" then
        export:playEmoteByCommand(emote)
        return
    elseif scully then
        export:cancelEmote()
        return
    elseif rpemotes and action == "play" then
        export:EmoteCommandStart(emote)
        return
    elseif rpemotes then
        export:EmoteCancel()
        return
    end
end

--- Function to check variation & texture types of ped.
---@param ped integer
---@param animType string
---@return boolean
local function checkType(ped, animType)
    if not ped or not animType then return false end

    local modelTypes = {
        male = "mp_m_freemode_01",
        female = "mp_f_freemode_01"
    }
    local drawableVariationType = {}
    local textureVariationType = {}
    local model = GetEntityModel(ped)
    local animConfig = config[animType]
    local drawableType = GetPedDrawableVariation(ped, animConfig.drawable)
    local textureType = GetPedTextureVariation(ped, animConfig.drawable)

    if lib.table.contains(config.blacklistedPeds, model) then
        TriggerEvent("chat:addMessage", "[Radio Anims] The ped model you're using is blacklisted!")
        return false
    end

    for gender, modelType in pairs(modelTypes) do
        if model == GetHashKey(modelType) then
            drawableVariationType = animConfig[gender].variations
            textureVariationType = animConfig[gender].textures
        end
    end

    if lib.table.contains(drawableVariationType, drawableType) and lib.table.contains(textureVariationType, textureType) then
        return true
    end

    return false
end


---comment function to handle radio animation
---@param enable boolean
local function handleRadioAnim(enable)
    local ped = cache.ped
    local veh = cache.vehicle
    local playerId = PlayerId()
    local isAiming = IsPlayerFreeAiming(playerId)
    local vehClass = GetVehicleClass(veh)

    if not DoesEntityExist(ped) or IsEntityDead(ped) or IsPauseMenuActive() then return end

    if enable then
        local emote = config.defaultEmote
        local chest = config.chestAnim.enable and checkType(ped, "chestAnim")
        local shoulder = config.shoulderAnim.enable and checkType(ped, "shoulderAnim")
        local ear = config.earpieceAnim.enable and checkType(ped, "earpieceAnim")
        local allowInCar = config.allowEmoteInVehicles
        local isBlacklisted = lib.table.contains(config.blacklistedClasses, vehClass)

        if not emote then return end

        if isAiming and shoulder then
            emote = config.shoulderAnim.emoteAiming
        elseif chest then
            emote = config.chestAnim.emote
        elseif shoulder then
            emote = config.shoulderAnim.emote
        elseif ear then
            emote = config.earpieceAnim.emote
        elseif allowInCar and not isBlacklisted then
            emote = config.earpieceAnim.emote
        end

        handleEmote(emote, "play")
        return
    end

    handleEmote()
end

if config.useKeybind then
    lib.addKeybind({
        name = "radioAnimKey",
        description = "Radio Animation Key",
        defaultKey = config.keybindKey,
        defaultMapper = "KEYBOARD",
        secondaryKey = config.controllerKey,
        secondaryMapper = "PAD_DIGITALBUTTON",
        onPressed = function(self)
            handleRadioAnim(true)
        end,
        onReleased = function(self)
            handleRadioAnim(false)
        end
    })
end

if config.useEvent then
    AddEventHandler("pma-voice:radioActive", function(radioTalking)
        handleRadioAnim(radioTalking)
    end)
end

if config.debug then
    RegisterCommand("getdrawable", function(source, args)
        if tonumber(args[1]) == nil then
            TriggerEvent("chat:addMessage", "Invalid Usage. Usage: /getdrawable <0-11>")
            return
        end
        local ped = cache.ped
        local componentId = args[1]
        local drawableType = GetPedDrawableVariation(ped, componentId)

        lib.print.info("Copied ".. drawableType .. " to your clipboard!")
        TriggerEvent("chat:addMessage", "Copied ".. drawableType .. " to your clipboard!")
        lib.setClipboard(drawableType)
    end, false)

    RegisterCommand("gettexture", function(source, args)
        if tonumber(args[1]) == nil then 
            TriggerEvent("chat:addMessage", "Invalid Usage. Usage: /gettexture <0-11>")
            return
        end
        local ped = cache.ped
        local componentId = tonumber(args[1])
        local drawableType = GetPedDrawableVariation(ped, componentId)
        local textureType = GetPedTextureVariation(ped, drawableType)

        lib.print.info("Copied ".. textureType .. " to your clipboard!")
        TriggerEvent("chat:addMessage", "Copied ".. textureType .. " to your clipboard!")
        lib.setClipboard(textureType)
    end, false)

    RegisterCommand("setradiochannel", function()
        exports["pma-voice"]:setRadioChannel(1)
    end, false)
end
