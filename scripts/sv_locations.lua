local notificationProvider = exports.r3_servicesmanager:load("notification")
local inventoryProvider = exports.r3_servicesmanager:load("inventory")
local usableItemsProvider = exports.r3_servicesmanager:load("usableItems")

local i18next = exports.r3_i18next:createInstanceWithPlugins()
i18next.init({
    fallbackLng = "en",
    backend = {
        loadPath = "/locales/{{lng}}.json",
    },
})

-- Choose a random item from the item_pool list
local function getNewRandomItem()
    local item = Config.itemPool[math.random(#Config.itemPool)]
    return { item = item.item, label = item.label }
end

-- Make a random location within the area
local function getNewRandomLocation()
    local offsetX = math.random(-Config.areaSize, Config.areaSize)
    local offsetY = math.random(-Config.areaSize, Config.areaSize)
    local pos = vector3(offsetX, offsetY, 0.0)
    if #pos > Config.areaSize then
        -- It's not within the circle, generate a new one instead
        return getNewRandomLocation()
    end
    return Config.baseLocation + pos
end

-- Generate a new target location
local function generateNewTarget()
    local newPos = getNewRandomLocation()
    local newData = getNewRandomItem()
    Prospecting.AddTarget(newPos.x, newPos.y, newPos.z, newData)
end

local function foundItem(player, data)
    if inventoryProvider.addItem(player, data.item, 1) then
        notificationProvider.showNotification(player, i18next.t("found_item", { label = data.label }), {
            style = "success",
            duration = 5000,
        })
    else
        notificationProvider.showNotification(player, i18next.t("found_item_full", { label = data.label }), {
            style = "error",
            duration = 5000,
        })
    end
end

RegisterServerEvent("r3_prospecting:activateProspecting")
AddEventHandler("r3_prospecting:activateProspecting", function()
    local player = source
    Prospecting.StartProspecting(player)
end)

CreateThread(function()
    -- Default difficulty
    Prospecting.SetDifficulty(1.0)

    -- Generate random extra targets
    for n = 0, Config.initialTargets do
        generateNewTarget()
    end

    -- The player collected something
    Prospecting.SetHandler(function(player, data, x, y, z)
        foundItem(player, data)
        -- Every time a
        generateNewTarget()
    end)

    -- The player started prospecting
    Prospecting.OnStart(function(player)
        notificationProvider.showNotification(player, i18next.t("started_prospecting"), {
            style = "info",
            duration = 2500,
        })
    end)

    -- The player stopped prospecting
    -- time in milliseconds
    Prospecting.OnStop(function(player, time)
        notificationProvider.showNotification(player, i18next.t("stopped_prospecting"), {
            style = "info",
            duration = 2500,
        })
    end)
end)

usableItemsProvider.registerUsableItem(Config.detectorItem, function(source)
    TriggerClientEvent("r3_prospecting:useDetector", source)
end)
