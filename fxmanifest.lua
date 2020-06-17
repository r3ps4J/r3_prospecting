name "r3_prospecting"
author "r3ps4J"
contact "discord.gg/bEWmBbg"

fx_version "adamant"
game "gta5"

description "Prospecting plugin for ESX"

dependencies {"prospecting", "r3_notifications"}
server_script "@prospecting/interface.lua"

client_script "scripts/cl_*.lua"
server_script "scripts/sv_*.lua"

client_script "config.lua"
server_script "config.lua"
