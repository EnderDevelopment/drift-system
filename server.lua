local ESX = exports['es_extended']:getSharedObject()

ESX.RegisterServerCallback('driftSystem:getPoints', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier
    
    MySQL.Async.fetchScalar('SELECT points FROM drift_points WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    }, function(points)
        if points then
            cb(points)
        else
            MySQL.Async.execute('INSERT INTO drift_points (identifier, points) VALUES (@identifier, @points)', {
                ['@identifier'] = identifier,
                ['@points'] = Config.DriftPoints
            }, function()
                cb(Config.DriftPoints)
            end)
        end
    end)
end)

RegisterServerEvent('driftSystem:updatePoints')
AddEventHandler('driftSystem:updatePoints', function(points)
    local xPlayer = ESX.GetPlayerFromId(source)
    local identifier = xPlayer.identifier
    
    MySQL.Async.execute('UPDATE drift_points SET points = @points WHERE identifier = @identifier', {
        ['@identifier'] = identifier,
        ['@points'] = points
    })
end)