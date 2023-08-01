RegisterServerEvent("groupemote:setEmote")
AddEventHandler("groupemote:setEmote", function(playerName, emoteName)
    local src = source
    TriggerClientEvent("groupemote:syncEmote", -1, src, playerName, emoteName)
end)
