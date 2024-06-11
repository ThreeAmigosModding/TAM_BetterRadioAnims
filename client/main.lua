---- Do not edit if you do not know what you"re doing ----

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

local animation = "sholder"

RegisterCommand("radioanimation", function(src, args, raw)

local ani = args[1]

if ani == nil then
ShowNotification("~r~!ERROR!: ~w~You must provide a animation, either: sholder, chest, or handheld!")
elseif ani == "sholder" then
animation = "sholder"
elseif ani == "chest" then
animation = "chest"
elseif ani == "handheld" then
animation = "handheld"
else
ShowNotification("~r~!ERROR!: ~w~Thats not a valid animation! The oprtions are: sholder, chest, or handheld!")
end

end, false)

TriggerEvent('chat:addSuggestion', '/radioanimation', 'Change the radio animation', {
    { name="Animation", help="Pick one of these: handheld, sholder, chest" }
})
---comment function to handle radio animation
---@param enable boolean
local function handleRadioAnim(enable)
    local ped = cache.ped
    local veh = cache.vehicle
    local isAiming = IsPlayerFreeAiming(cache.playerId)
    local vehClass = GetVehicleClass(veh)

    if not DoesEntityExist(ped) or IsEntityDead(ped) or IsPauseMenuActive() then return end

    if enable then
        local emote = "radio2"

        if not emote then return end

        if animation == "chest" then
            emote = "radiochest"
        elseif animation == "shoulder" then
            emote = "radio"
        elseif animation == "handheld" then
            emote = "wt4"
        end

        exports["rpemotes"]:EmoteCommandStart(emote)
        return
    end

   exports["rpemotes"]:EmoteCancel()
end


    AddEventHandler("pma-voice:radioActive", function(radioTalking)
        handleRadioAnim(radioTalking)
    end)
