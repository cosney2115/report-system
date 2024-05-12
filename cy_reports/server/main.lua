local reports = {}

local function hasRole(xPlayer)
    for i = 1, #Config.Roles do
        local role = Config.Roles[i]

        if xPlayer.getGroup() == role then
            return true
        end
    end

    return false
end

RegisterNetEvent('cy_reports:server:sendReport', function(title, description)
    local _source = source

    reports[#reports + 1] = {
        username = GetPlayerName(_source),
        title = title,
        description = description,
        player = _source
    }
end)

ESX.RegisterServerCallback('cy_reports:getReports', function(source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if not xPlayer then
        cb({})
        return
    end

    if not hasRole(xPlayer) then
        Config.BanFunction(_source)
        cb({})
        return
    end

    if #reports == 0 then
        cb({})
        return
    end

    cb(reports)
end)

RegisterNetEvent('cy_reports:server:deleteReport', function(player)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if not xPlayer then
        return
    end

    if not hasRole(xPlayer) then
        Config.BanFunction(_source)
        return
    end

    for i = 1, #reports do
        if reports[i].player == player then
            reports[i] = nil
            break
        end
    end
end)

RegisterCommand(Config.AdminCommand, function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        return
    end

    if not hasRole(xPlayer) then
        return
    end

    if #reports == 0 then
        return
    end

    TriggerClientEvent('cy_reports:client:openReports', source, reports)
end, true)