local notificationProvider = exports.r3_servicesmanager:load("notification")

local i18next = exports.r3_i18next:createInstanceWithPlugins()
i18next.init({
    fallbackLng = "en",
    backend = {
        loadPath = "/locales/{{lng}}.json",
    },
})

CreateThread(function()
    AddTextEntry("PROSP_BLIP", Config.blip.text)
    local blip = AddBlipForCoord(Config.baseLocation)
    SetBlipSprite(blip, Config.blip.sprite)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("PROSP_BLIP")
    EndTextCommandSetBlipName(blip)
    local areaBlip = AddBlipForRadius(Config.baseLocation, Config.areaSize)
    SetBlipSprite(areaBlip, 10)
end)

RegisterNetEvent("r3_prospecting:startProspecting")
AddEventHandler("r3_prospecting:startProspecting", function()
    local pos = GetEntityCoords(PlayerPedId())

    -- Make sure the player is within the prospecting zone before they start
    local dist = #(pos - Config.baseLocation)
    if dist < Config.areaSize then
        TriggerServerEvent("r3_prospecting:activateProspecting")
    else
        notificationProvider.showNotification(i18next.t("not_in_area"), {
            style = "error",
            duration = 5000,
        })
    end
end, false)

RegisterNetEvent("r3_prospecting:useDetector")
AddEventHandler("r3_prospecting:useDetector", function()
    if IsPedInAnyVehicle(PlayerPedId()) then
        notificationProvider.showNotification(i18next.t("in_vehicle"), {
            style = "error",
            duration = 5000,
        })
    else
        TriggerEvent("r3_prospecting:startProspecting")
    end
end)
