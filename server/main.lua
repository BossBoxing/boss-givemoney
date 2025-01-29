local RSGCore = exports['rsg-core']:GetCoreObject()

-- Server-side event to handle money transfer
RegisterNetEvent('rsg:giveMoney', function(targetPlayerId, amount)
    local src = source
    local xPlayer = RSGCore.Functions.GetPlayer(src)
    local targetPlayer = RSGCore.Functions.GetPlayer(tonumber(targetPlayerId))
    
    if not xPlayer then
        print("Source player not found!")
        TriggerClientEvent('lib.notify', src, { title = 'Error', description = 'Your player data could not be found.', type = 'error' })
        return
    end

    if not targetPlayer then
        -- print("Target player not found!")
        TriggerClientEvent('lib.notify', src, { title = 'Error', description = 'Target player not found.', type = 'error' })
        return
    end

    if xPlayer.Functions.GetMoney('cash') >= amount then
        xPlayer.Functions.RemoveMoney('cash', amount)
        targetPlayer.Functions.AddMoney('cash', amount)

        TriggerClientEvent('lib.notify', xPlayer.PlayerData.source, { title = 'Success', description = 'You gave $' .. amount .. ' to ' .. targetPlayer.PlayerData.charinfo.firstname, type = 'success' })
        TriggerClientEvent('lib.notify', targetPlayer.PlayerData.source, { title = 'Success', description = 'You received $' .. amount .. ' from ' .. xPlayer.PlayerData.charinfo.firstname, type = 'success' })
    else
        -- print("Not enough money!")
        TriggerClientEvent('lib.notify', xPlayer.PlayerData.source, { title = 'Error', description = 'You don\'t have enough money.', type = 'error' })
    end
end)