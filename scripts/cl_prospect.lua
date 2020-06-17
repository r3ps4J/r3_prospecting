ESX = nil
local blip_location = vector3(1580.9, 6592.204, 13.84828)
local blip = nil
local area_blip = nil
local area_size = 100.0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

CreateThread(function()
    AddTextEntry("PROSP_BLIP", Config.ProspectingBlipText)
    blip = AddBlipForCoord(blip_location)
    SetBlipSprite(blip, Config.ProspectingBlipSprite)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("PROSP_BLIP")
    EndTextCommandSetBlipName(blip)
    area_blip = AddBlipForRadius(blip_location, area_size)
    SetBlipSprite(area_blip, 10)
end)

RegisterNetEvent("r3_prospecting:startProspecting")
AddEventHandler("r3_prospecting:startProspecting", function()
    local pos = GetEntityCoords(PlayerPedId())

    -- Make sure the player is within the prospecting zone before they start
    local dist = #(pos - blip_location)
    if dist < area_size then
        TriggerServerEvent("r3_prospecting:activateProspecting")
    else
		exports["r3_notifications"]:clientSendNotification("You are not in a prospecting area!", "error", 5000)
	end
end, false)

RegisterNetEvent("r3_prospecting:useDetector")
AddEventHandler("r3_prospecting:useDetector", function()
	if IsPedInAnyVehicle(PlayerPedId()) then
		exports["r3_notifications"]:clientSendNotification("You can not prospect from a vehicle!", "error", 5000)
	else
		TriggerEvent("r3_prospecting:startProspecting")
	end
end)