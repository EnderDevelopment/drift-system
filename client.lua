local ESX = exports['es_extended']:getSharedObject()

local currentGravity = Config.DefaultGravity
local driftPoints = Config.DriftPoints

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        
        if DoesEntityExist(vehicle) and IsPedInAnyVehicle(playerPed, false) then
            local speed = GetEntitySpeed(vehicle)
            local isDrifting = GetEntityRoll(vehicle) > 0.5 or GetEntityRoll(vehicle) < -0.5
            
            if isDrifting and speed > 10.0 then
                driftPoints = driftPoints + 1
                
                for _, level in ipairs(Config.GravityLevels) do
                    if driftPoints >= level.level then
                        currentGravity = level.gravity
                        break
                    end
                end
                
                SetGravityLevel(currentGravity)
                
                TriggerServerEvent('driftSystem:updatePoints', driftPoints)
            end
        end
    end
end)

RegisterNetEvent('driftSystem:updateGravity')
AddEventHandler('driftSystem:updateGravity', function(gravity)
    currentGravity = gravity
    SetGravityLevel(currentGravity)
end)

function SetGravityLevel(gravity)
    SetGravityLevel(gravity)
end