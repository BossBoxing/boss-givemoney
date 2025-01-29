-- Ensure rsg-target and RSG V2 are properly installed on your RedM server.

local RSGCore = exports['rsg-core']:GetCoreObject()

-- Register the target for players using ox_target
exports['ox_target']:addGlobalPlayer({
    {
        name = 'give_money', -- Unique name for the action
        label = 'Give Money', -- Label shown in the menu
        icon = 'fas fa-money-bill-wave', -- Font Awesome icon
        onSelect = function(data)
            local targetEntity = data.entity -- Entity ID from ox_target
            local targetPlayerIndex = NetworkGetPlayerIndexFromPed(targetEntity) -- Get player index from entity
            local targetServerId = GetPlayerServerId(targetPlayerIndex) -- Convert player index to server ID

            if IsEntityAPed(targetEntity) and IsPedAPlayer(targetEntity) then
                local targetPlayerIndex = NetworkGetPlayerIndexFromPed(targetEntity)
                local targetServerId = GetPlayerServerId(targetPlayerIndex)
            
                if targetServerId and targetServerId > 0 then
                    OpenGiveMoneyMenu(targetServerId)
                else
                    lib.notify({ title = 'Error', description = 'Player not found.', type = 'error' })
                end
            else
                lib.notify({ title = 'Error', description = 'Invalid target.', type = 'error' })
            end
        end,
    },
}, 1.0) -- Interaction distance

-- Function to open the money-giving menu
function OpenGiveMoneyMenu(targetPlayerId)
    local input = lib.inputDialog('Give Money', {
        {
            type = 'number',
            label = 'Amount to Give',
            placeholder = 'Enter the amount here',
        },
    })

    if input then
        local amount = tonumber(input[1])

        if amount and amount > 0 then
            TriggerServerEvent('rsg:giveMoney', targetPlayerId, amount)
        else
            lib.notify({ title = 'Error', description = 'Invalid amount entered.', type = 'error' })
        end
    end
end
