local rpemotes = GetResourceState('rpemotes') == 'started' and true or false
local scully = GetResourceState('scully_emotemenu') == 'started' and true or false
if not rpemotes and not scully then return end
local export = GetResourceState('rpemotes') == 'started' and exports['rpemotes'] or exports['scully_emotemenu']

local function CheckType(ped, type)
    local male = GetHashKey("mp_m_freemode_01")
    local female = GetHashKey("mp_f_freemode_01")
    local drawable = GetPedDrawableVariation(ped, config["Drawable Variations"])
    local ear = GetPedPropIndex(ped, 2)
    local model = GetEntityModel(ped)
    if type == "chest" then
        if model == male then
            for _, variation in pairs(config["Chest Animations"]["Male"]) do
                if drawable == variation then return true end
            end
        elseif model == female then
            for _, variation in pairs(config["Chest Animations"]["Female"]) do
                if drawable == variation then return true end
            end
        else return false
        end
    elseif type == "shoulder" then 
        if model == male then
            for _, variation in pairs(config["Shoulder Animations"]["Male"]) do
                if drawable == variation then return true end
            end
        elseif model == female then
            for _, variation in pairs(config["Shoulder Animations"]["Female"]) do
                if drawable == variation then return true end
            end
        else return false
        end
    elseif type == "ear" then 
        if model == male then
            for _, variation in pairs(config["Ear Piece Animations"]["Male"]) do
                if ear == variation then return true end
            end
        elseif model == female then
            for _, variation in pairs(config["Ear Piece Animations"]["Female"]) do
                if ear == variation then return true end
            end
        else return false
        end
    else return false end
end

local function playEmote(emoteName)
  if rpemotes then export:EmoteCommandStart(emoteName)
  else export:playEmoteByCommand(emoteName) end
end

local function stopEmote()
  if rpemotes then export:EmoteCancel()
  else export:cancelEmote() end
end

AddEventHandler("pma-voice:radioActive", function(radioTalking)
    local ped = cache.ped
    local id = cache.playerId
    local vehicle = cache.vehicle
    local inVeh = IsPedInAnyVehicle(ped)
    local exist = DoesEntityExist(ped)
    local dead = IsEntityDead(ped)
    local pause = IsPauseMenuActive()
    local aiming = IsPlayerFreeAiming(id)
    local class = GetVehicleClass(vehicle)
    local shoulder = CheckType(ped, "shoulder")
    local chest = CheckType(ped, "chest")
    local ear = CheckType(ped, "ear")
    if radioTalking and exist and not dead and not pause then
        if not inVeh then
            if shoulder then
                if aiming then
                    playEmote('radio2')
                else
                    playEmote('radio')
                end
            elseif chest and not aiming then
                playEmote('radiochest')
            elseif not shoulder and not chest and not aiming and not ear then
                playEmote('wt2')
            elseif not shoulder and not chest and not aiming and ear then
                playEmote('earpiece')
            end
        elseif inVeh and class ~= 8 and class ~= 13 and class ~= 15 and class ~= 16 and not ear then
            playEmote('wt2')
        elseif inVeh and class ~= 8 and class ~= 13 and class ~= 15 and class ~= 16 and ear then
            playEmote('earpiece')
        end
    else
        stopEmote()
    end
end)
