-- Gnomish Treasure Detector - Alerts the user to nearby rares or treasures to collect

-----------------------------
-- Variables & Utility Functions
-----------------------------
local A, L = ...
local Debug = GTD_Debug.Print -- Debugging function
local SafeCall = GTD_Debug.SafeCall -- Safe function wrapper to prevent crashes

-- Function to send messages only to the player’s chat frame
local function GTD_Print(msg)
    DEFAULT_CHAT_FRAME:AddMessage("|cffffcc00[GTD]:|r " .. msg) -- Prints only to the player's chat
end

-- Function to send alerts based on user settings
local function SendAlert(message)
    if GTD_Settings.chatOutput then
        SendChatMessage(message, GTD_Settings.chatOutput) -- Sends alert to selected chat output
    end
    if GTD_Settings.soundEnabled then
        PlaySoundFile(567397, "Master") -- Plays alert sound if enabled
    end
end

-----------------------------
-- Vignette Detection & Alerts
-----------------------------

-- Function triggered when a vignette (rare NPC, treasure) appears
local function OnVignetteAdded(self, event, id)
    if not id then return end -- Ensure vignette ID is valid

    local vignettes = self.vignettes
    if vignettes[id] then
        if GTD_Settings.debugMode then Debug("Ignoring duplicate vignette:", id) end
        return
    end

    -- Fetch vignette information safely
    local vignetteInfo = SafeCall(C_VignetteInfo.GetVignetteInfo, id)
    if not vignetteInfo or not vignetteInfo.name then return end

    -- Check if vignette is ignored
    if IgnoredVignettes and IgnoredVignettes[vignetteInfo.name] then
        if GTD_Settings.debugMode then Debug("Ignored:", vignetteInfo.name) end
        return
    end

    -- Fetch vignette atlas texture safely
    local atlasInfo = SafeCall(C_Texture.GetAtlasInfo, vignetteInfo.atlasName)
    if not atlasInfo then
        if GTD_Settings.debugMode then Debug("Atlas info missing for:", vignetteInfo.name) end
        return
    end

    -- Format vignette icon
    local str = string.format("|TInterface\\MINIMAP\\ObjectIconsAtlas:0:0:0:0:256:256:%d:%d:%d:%d|t",
        atlasInfo.leftTexCoord * 256, atlasInfo.rightTexCoord * 256,
        atlasInfo.topTexCoord * 256, atlasInfo.bottomTexCoord * 256)

    -- Send alert
    SendAlert(str .. " " .. vignetteInfo.name .. " spotted!")

    -- Mark vignette as seen
    vignettes[id] = true
end

-----------------------------
-- Event Handling
-----------------------------

local eventHandler = CreateFrame("Frame")
eventHandler:RegisterEvent("PLAYER_LOGIN")

eventHandler:SetScript("OnEvent", function(self, event, ...)
    if event == "PLAYER_LOGIN" then
        if GTD_Settings.debugMode then Debug("Addon Loaded. Waiting for vignettes...") end
        self:UnregisterEvent("PLAYER_LOGIN")
        self:RegisterEvent("VIGNETTE_MINIMAP_UPDATED")
    elseif event == "VIGNETTE_MINIMAP_UPDATED" then
        SafeCall(OnVignetteAdded, self, event, ...)
    end
end)

eventHandler.vignettes = {}

-----------------------------
-- Slash Commands
-----------------------------

SLASH_GTD1 = "/gtd"

SlashCmdList["GTD"] = function(msg)
    local args = { strsplit(" ", msg) }

    if args[1] == "debug" then
        GTD_Settings.debugMode = not GTD_Settings.debugMode
        GTD_Print("Debug Mode " .. (GTD_Settings.debugMode and "|cff00ff00Enable
