Config = {
    -- Blip options
    blip = {
        text = "Prospecting",
        sprite = 485,
    },

    -- Location where you can prospect
    baseLocation = vector3(1580.9, 6592.204, 13.84828),
    areaSize = 100.0,

    -- The item players use to start prospecting
    detectorItem = "detector",

    -- Initial amount of targets to generate at the start of the script
    initialTargets = 20,

    -- Available items that targets can be generated with
    itemPool = {
        { item = "bones", label = "Bones" },
        { item = "nuts_and_bolts", label = "Nuts and Bolts" },
        { item = "gold_ring", label = "a Golden ring" },
        { item = "dragon_scales", label = "Dragon Scales" },
        { item = "metalscrap", label = "Metal Scrap" },
    },
}
