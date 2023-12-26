local scully = lib.checkDependency("scully_emotemenu", "1.8.0")
local rpemotes = lib.checkDependency("rpemotes", "1.3.8")

if scully and not rpemotes then 
    export = exports['scully_emotemenu']
elseif not scully and rpemotes then
    export = exports['rpemotes']
else
    lib.print.debug('rpemotes or scully_emotemenu is either outdated or missing or both installed. Please update and make sure you only have one of the resources installed and running.')
end

local function PlayEmote(emote)
    if scully and not rpemotes then export:playEmoteByCommand(emote) return end
    if rpemotes and not scully then export:EmoteCommandStart(emote) return end
end

local function StopEmote()
    if scully and not rpemotes then export:cancelEmote() return end
    if rpemotes and not scully then export:EmoteCancel() return end
end

local function CheckType(ped, animType)
    local male = GetHashKey("mp_m_freemode_01")
    local female = GetHashKey("mp_f_freemode_01")
    local model = GetEntityModel(ped)

    if animType == "chest" and config.chestAnim.enable then
        local drawableType = GetPedDrawableVariation(ped, config.chestAnim.drawable)

        if model == male then
            for _, variation in pairs(config.chestAnim.male) do
                if drawableType == variation then return true end
            end
        elseif model == female then
            for _, variation in pairs(config.chestAnim.female) do
                if drawableType == variation then return true end
            end
        elseif lib.table.contains(config.blacklistedPeds, pedMdl) then
            TriggerEvent('chat:addMessage', "That model is blacklisted!")
            if debug then lib.print.debug('That model is blacklisted!') end
            return "blacklisted"
        else
            if debug then lib.print.debug('Unspecified drawable, reverting to default animation.') end -- error
            return false
        end
    elseif animType == "shoulder" and config.shoulderAnim.enable then
        local drawableType = GetPedDrawableVariation(ped, config.shoulderAnim.drawable)

        if model == male then
            for _, variation in pairs(config.shoulderAnim.male) do
                if drawableType == variation then return true end
            end
        elseif model == female then
            for _, variation in pairs(config.shoulderAnim.female) do
                if drawableType == variation then return true end
            end
        elseif lib.table.contains(config.blacklistedPeds, pedMdl) then
            TriggerEvent('chat:addMessage', "That model is blacklisted!")
            if debug then lib.print.debug('That model is blacklisted!') end
            return "blacklisted"
        else
            if debug then lib.print.debug('Unspecified drawable, reverting to default animation.') end
            return false
        end
    elseif animType == "ear" and config.earpieceAnim.enable then
        local drawableType = GetPedDrawableVariation(ped, config.earpieceAnim.drawable)

        if model == male then
            for _, variation in pairs(config.earpieceAnim.male) do
                if drawableType == variation then return true end
            end
        elseif model == female then
            for _, variation in pairs(config.earpieceAnim.female) do
                if drawableType == variation then return true end
            end
        elseif lib.table.contains(config.blacklistedPeds, pedMdl) then
            TriggerEvent('chat:addMessage', "That model is blacklisted!")
            if debug then lib.print.debug('That model is blacklisted!') end
            return "blacklisted"
        else
            if debug then lib.print.debug('Unspecified drawable, reverting to default animation.') end
            return false
        end
    elseif not animType then
        lib.print.debug("You have an error in your config or animType is nil.")
    else 
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
        if not veh and CheckType(ped, "chest") then
            PlayEmote('radiochest')
        elseif not veh and CheckType(ped, "shoulder") and not aiming then
            PlayEmote('radio')
        elseif not veh and CheckType(ped, "shoulder") and aiming then
            PlayEmote('radio2')
        elseif not veh and CheckType(ped, "ear") then
            PlayEmote('earpiece')
        elseif veh and not CheckType(ped, "ear") and not lib.table.contains(config.blacklistedClasses, vehClass) then
            PlayEmote('wt2')
        elseif veh and CheckType(ped, "ear") and not lib.table.contains(config.blacklistedClasses, vehClass) then
            PlayEmote('earpiece')
        elseif CheckType(ped, "chest") or CheckType(ped, "shoulder") or CheckType(ped, "ear") == "blacklisted" then
            return
        elseif not CheckType(ped, "chest") or not CheckType(ped, "shoulder") or not CheckType(ped, "ear") then
            PlayEmote('wt2')
        elseif config.debug then
            lib.print.debug('Unknown Error with event handler pma-voice:radioActive')
        end
    elseif not radioTalking then
        StopEmote()
    elseif config.debug then
        lib.print.debug('Unknown Error with event handler pma-voice:radioActive')
    end
end)
