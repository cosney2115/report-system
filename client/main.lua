RegisterCommand(Config.ReportCommand, function()
    local input = lib.inputDialog('Report', {
        {type = 'input', label = 'Title', description = 'Max 16 characters', required = true, min = 4, max = 16},
        {type = 'input', label = 'Description', description = 'Max 64 characters', required = true, min = 4, max = 64}
      })

    if not input or not input[1] or not input[2] then
        return
    end
    ESX.ShowNotification(Config.Notify.ReportSent)
    TriggerServerEvent('cy_reports:server:sendReport', input[1], input[2])
end, false)

RegisterNetEvent('cy_reports:client:openReports', function(data)
    local options = {}
    
    for i = 1, #data do
        options[#options + 1] = {
            title = data[i].title,
            description = data[i].description,
            metadata = {
                {label = 'Name: ' .. data[i].username, value = 'ID: ' .. data[i].player},
            },
            onSelect = function()
                local targetSource = data[i].player

                lib.registerContext({
                    id = 'reports_menu',
                    title = 'Reports Menu',
                    options = {
                        {
                            title = 'Teleport to player',
                            onSelect = function()
                                local targetServerId = GetPlayerFromServerId(targetSource)
                                local targetPed = GetPlayerPed(targetServerId)
                                local targetCoords = GetEntityCoords(targetPed)
                                
                                SetEntityCoords(cache.ped, targetCoords.x, targetCoords.y, targetCoords.z, false, false, false, false)
                                ESX.ShowNotification(Config.Notify.Teleported)
                            end,
                        },
                        {
                            title = 'Revive Player',
                            onSelect = function()
                                TriggerEvent('esx_ambulancejob:revive', targetSource)
                                ESX.ShowNotification(Config.Notify.Revived)
                            end
                        },
                        {
                            title = 'Close report',
                            onSelect = function()
                                TriggerServerEvent('cy_reports:server:deleteReport', targetSource)
                                ESX.ShowNotification(Config.Notify.ReportClosed)
                            end
                        },
                        {
                            title = "Back",
                            onSelect = function()
                                lib.showContext('reports_data')
                            end
                        }
                    }
                })
                lib.showContext('reports_menu')
            end
        }
    end

    lib.registerContext({
        id = 'reports_data',
        title = 'Reports',
        options = options
    })
    lib.showContext('reports_data')
end)


TriggerEvent('chat:addSuggestion', '/' .. Config.ReportCommand, Config.Suggestions[Config.ReportCommand])
TriggerEvent('chat:addSuggestion', '/' .. Config.AdminCommand, Config.Suggestions[Config.AdminCommand])