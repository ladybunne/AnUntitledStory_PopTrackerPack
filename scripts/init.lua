DEBUG = true
ENABLE_DEBUG_LOG = true

ScriptHost:LoadScript("scripts/utils.lua")
ScriptHost:LoadScript("scripts/logic/logic.lua")

Tracker:AddItems("items/abilities.json")
Tracker:AddItems("items/items.json")
Tracker:AddItems("items/crystals.json")

Tracker:AddMaps("maps/maps.json")

Tracker:AddLocations("locations/locations.json")

Tracker:AddLayouts("layouts/abilities.json")
Tracker:AddLayouts("layouts/items.json")
Tracker:AddLayouts("layouts/crystals.json")
Tracker:AddLayouts("layouts/map.json")

if PopVersion and PopVersion >= "0.18.0" then
    ScriptHost:LoadScript("scripts/autotracking.lua")
end