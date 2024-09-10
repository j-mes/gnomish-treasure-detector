-- rVignette - Alerts the user to nearby rares or treasures to collect
-- zork, 2018
-- Neav (fix)
-- Used by Howl

-----------------------------
-- Variables
-----------------------------
local A, L = ...

-----------------------------
-- Functions
-----------------------------
local function OnVignetteAdded(self, event, id)
    if not id then return end
    self.vignettes = self.vignettes or {}
    if self.vignettes[id] then return end
    local vignetteInfo = C_VignetteInfo.GetVignetteInfo(id)
    if not vignetteInfo then return end

    -- Adding fix from Neav
    local atlasInfo = C_Texture.GetAtlasInfo(vignetteInfo.atlasName)
    local left = atlasInfo.leftTexCoord * 256
    local right = atlasInfo.rightTexCoord * 256
    local top = atlasInfo.topTexCoord * 256
    local bottom = atlasInfo.bottomTexCoord * 256
    local str = "|TInterface\\MINIMAP\\ObjectIconsAtlas:0:0:0:0:256:256:" ..
        (left) .. ":" .. (right) .. ":" .. (top) .. ":" .. (bottom) .. "|t"

    -- Warlords of Draenor: Garrison
    if vignetteInfo.name ~= "Garrison Cache"
        and vignetteInfo.name ~= "Full Garrison Cache"
        -- Dragonflight: Open World - NPCs
        and vignetteInfo.name ~= "Rostrum of Transformation"
        and vignetteInfo.name ~= "Renown Quartermaster"
        and vignetteInfo.name ~= "Bronze Timekeeper"
        -- The War Within: Hallowfall - Keyflames
        and vignetteInfo.name ~= "Bleak Sand Keyflame"
        and vignetteInfo.name ~= "Duskrise Acreage Keyflame"
        and vignetteInfo.name ~= "Fungal Field Keyflame"
        and vignetteInfo.name ~= "Light's Blooming Keyflame"
        and vignetteInfo.name ~= "Stillstone Pond Keyflame"
        and vignetteInfo.name ~= "The Faded Shore Keyflame"
        and vignetteInfo.name ~= "The Whirring Field Keyflame"
        and vignetteInfo.name ~= "Torchlight Mine Keyflame"
        -- The War Within: Delves - Companions
        and vignetteInfo.name ~= "Brann Bronzebeard"
        and vignetteInfo.name ~= nil
    then
        RaidNotice_AddMessage(RaidWarningFrame, str .. " " .. vignetteInfo.name .. " spotted!",
            ChatTypeInfo["RAID_WARNING"])
        PlaySoundFile(567397)
        print(str .. " " .. vignetteInfo.name, "spotted!")
        self.vignettes[id] = true
    end
end

-----------------------------
-- Init
-----------------------------
local eventHandler = CreateFrame("Frame")
eventHandler:RegisterEvent("VIGNETTE_MINIMAP_UPDATED")
eventHandler:SetScript("OnEvent", OnVignetteAdded)
