fx_version "adamant"
game "gta5"

name "r3_prospecting"
description "Prospecting plugin"
author "r3ps4J"
contact "discord.gg/bEWmBbg"

dependencies {
    "prospecting",
    "r3_servicesmanager",
    "r3_i18next",
}

shared_script "config.lua"

client_script "scripts/cl_*.lua"

server_scripts {
    "@prospecting/interface.lua",
    "scripts/sv_*.lua",
}

files "locales/**/*.json"
