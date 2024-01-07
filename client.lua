local playerInZone = false
local isEmoteActive = false
local QBCore = exports['qb-core']:GetCoreObject()


local function ShowNotification(text, type)
    if Config.USE_Notify then
    if Config.Notify == 'qb' then
        QBCore.Functions.Notify(text, type)       
    elseif Config.Notify == 'ox' then 
        lib.notify({description = text, type = type})
    end
    else
    local message = {
        color = {255, 0, 0},
        args = {"[Group Emote]", text}
    }
    TriggerEvent("chat:addMessage", message)
end
end

RegisterCommand("setemote", function(source, args, rawCommand)
    local newEmoteName = args[1]
    local playerName = GetPlayerName(PlayerId())

    if not playerInZone then
        ShowNotification("You are not in a group emote zone. Use this command within a group emote zone.")
        return
    end

    if newEmoteName then
        TriggerServerEvent("groupemote:setEmote", playerName, newEmoteName)
    else
        ShowNotification("Usage: /setemote [emoteName] - You must specify the emote name.")
    end
end)

RegisterNetEvent("groupemote:syncEmote")
AddEventHandler("groupemote:syncEmote", function(playerId, playerName, newEmoteName)
    if playerInZone then
        if isEmoteActive then
        if Config.Emotes == 'rpemotes' then       
            exports[Config.exportName]:EmoteCancel(true)
        elseif Config.Emotes == 'scully_emotemenu' then
            exports.scully_emotemenu:cancelEmote(true)
        end
            isEmoteActive = false
        end

        Config.emoteName = newEmoteName
        ShowNotification(playerName .. " changed the emote to: " .. Config.emoteName)

        if not isEmoteActive then
        if Config.Emotes == 'rpemotes' then            
            exports[Config.exportName]:EmoteCommandStart(Config.emoteName, 1, true)
        elseif Config.Emotes == 'scully_emotemenu' then
            exports.scully_emotemenu:playEmoteByCommand(Config.emoteName, 1, true) 
        end
        isEmoteActive = true
        end
    end
end)



Citizen.CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed, false)

        local prevPlayerInZone = playerInZone
        playerInZone = false
        for _, zone in ipairs(Config.zones) do
            local distance = GetDistanceBetweenCoords(playerCoords, zone.center, true)
            if distance <= zone.radius then
                playerInZone = true
                break
            end
        end

        if playerInZone and not prevPlayerInZone then
            ShowNotification("You have entered a group emote zone.")
        elseif not playerInZone and prevPlayerInZone then
            ShowNotification("You have left the group emote zone.")
            if isEmoteActive then
                if Config.Emotes == 'rpemotes' then       
                    exports[Config.exportName]:EmoteCancel(true)
                elseif Config.Emotes == 'scully_emotemenu' then
                    exports.scully_emotemenu:cancelEmote(true)
                end
                isEmoteActive = false
            end
        end

        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustPressed(0, 73) and exports[Config.exportName]:IsPlayerInAnim() then
            if Config.Emotes == 'rpemotes' then       
                exports[Config.exportName]:EmoteCancel(true)
            elseif Config.Emotes == 'scully_emotemenu' then
                exports.scully_emotemenu:cancelEmote(true)
            end
            isEmoteActive = false
        end
    end
end)
