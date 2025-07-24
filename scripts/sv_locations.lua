local notificationProvider = exports.r3_servicesmanager:load("notification")
local inventoryProvider = exports.r3_servicesmanager:load("inventory")
local usableItemsProvider = exports.r3_servicesmanager:load("usableItems")

local locations = {
    {x = 1600.185, y = 6622.714, z = 15.85106, data = {
        item = "bones",
		label = "Bones",
    }},
    {x = 1548.082, y = 6633.096, z = 2.377085, data = {
        item = "nuts_and_bolts",
		label = "Nuts and Bolts"
    }},
    {x = 1504.235, y = 6579.784, z = 4.365892, data = {
        item = "gold_ring",
        label = "a Golden ring",
    }},
    {x = 1580.016, y = 6547.394, z = 15.96557, data = {
        item = "dragon_scales",
        label = "Dragon Scales",
    }},
    {x = 1634.586, y = 6596.688, z = 22.55633, data = {
        item = "metalscrap",
		label = "Metal Scrap",
    }},
}

local item_pool = {
    {item = "bones", label = "Bones"},
    {item = "nuts_and_bolts", label = "Nuts and Bolts"},
    {item = "gold_ring", label = "a Golden ring"},
    {item = "dragon_scales", label = "Dragon Scales"},
    {item = "metalscrap", label = "Metal Scrap"},
}

-- Area to create targets within, matches the client side blips
local base_location = vector3(1580.9, 6592.204, 13.84828)
local area_size = 100.0

-- Choose a random item from the item_pool list
local function getNewRandomItem()
    local item = item_pool[math.random(#item_pool)]
    return {item = item.item, label = item.label}
end

-- Make a random location within the area
local function getNewRandomLocation()
    local offsetX = math.random(-area_size, area_size)
    local offsetY = math.random(-area_size, area_size)
    local pos = vector3(offsetX, offsetY, 0.0)
    if #(pos) > area_size then
        -- It's not within the circle, generate a new one instead
        return getNewRandomLocation()
    end
    return base_location + pos
end

-- Generate a new target location
local function generateNewTarget()
    local newPos = getNewRandomLocation()
    local newData = getNewRandomItem()
    Prospecting.AddTarget(newPos.x, newPos.y, newPos.z, newData)
end

local function foundItem(player, data)
	if inventoryProvider.addItem(player, data.item, 1) then
        notificationProvider.showNotification(player, "You found " .. data.label .. "!", {
            style = "success",
            duration = 5000,
        })
	else
        notificationProvider.showNotification(player, "You found " .. data.label .. " but your inventory is full!", {
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

    -- Add a list of targets
    -- Each target needs an x, y, z and data entry
    Prospecting.AddTargets(locations)

    -- Generate 10 random extra targets
    for n = 0, 10 do
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
        notificationProvider.showNotification(player, "Started prospecting", {
            style = "info",
            duration = 2500,
        })
    end)

    -- The player stopped prospecting
    -- time in milliseconds
    Prospecting.OnStop(function(player, time)
        notificationProvider.showNotification(player, "Stopped prospecting", {
            style = "info",
            duration = 2500,
        })
    end)
end)

usableItemsProvider.registerUsableItem("detector", function(source)
	TriggerClientEvent("r3_prospecting:useDetector", source)
end)
