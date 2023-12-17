local export = nil
local rpemotes = GetResourceState("rpemotes")
local scully = GetResourceState("scully_emotemenu")

if rpemotes == "missing" and scully == "missing" then return end

CreateThread(function()
    if rpemotes == "started" then
        export = exports["rpemotes"]
    elseif scully == "started" then
        export = exports["scully_emotemenu"]
    end
end)

local function CheckType(ped, type)
    local drawable = GetPedDrawableVariation(ped, config["Drawable Variations"])
    if type == "chest" then
        for _, variation in pairs(config["Chest Animations"]) do
            if drawable == variation then return true end
        end
    elseif type == "shoulder" then 
        for _, variation in pairs(config["Shoulder Animations"]) do
            if drawable == variation then return true end
        end
    else return false end
end

local function earPiece(ped)
    local ear = GetPedPropIndex(ped, 2)
    for _, variation in pairs(config["Ear Piece Animations"]) do
        if ear == variation then return true end
    end
end

local function playEmote(emoteName)
    if rpemotes == "started" then export:EmoteCommandStart(emoteName)
    elseif scully == "started" then export:playEmoteByCommand(emoteName) end
end

local function stopEmote()
    if rpemotes == "started" then export:EmoteCancel()
    elseif scully == "started" then export:cancelEmote() end
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
    local ear = earPiece(ped)
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