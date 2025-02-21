-- Settings menu for Gnomish Treasure Detector
local addonName = ...

local GTD_Settings_Defaults = {
    debugMode = false, -- Default: Debug Mode OFF
    soundEnabled = true, -- Default: Sound ON
    chatOutput = "RAID_WARNING", -- Default: Use Raid Warning for alerts
}

-- Function to initialize settings with defaults if missing
local function GTD_LoadSettings()
    if not GTD_Settings then
        GTD_Settings = {} -- Create the table if it doesn't exist
    end
    -- Set default values if missing
    for key, value in pairs(GTD_Settings_Defaults) do
        if GTD_Settings[key] == nil then
            GTD_Settings[key] = value
        end
    end
end

-- Function to create the settings UI in WoW's Interface Options
local function GTD_CreateSettingsMenu()
    local panel = CreateFrame("Frame", addonName .. "SettingsPanel", InterfaceOptionsFramePanelContainer)
    panel.name = "Gnomish Treasure Detector"
    
    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("Gnomish Treasure Detector")

    -- Debug Mode Checkbox
    local debugCheck = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
    debugCheck:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -10)
    debugCheck.Text:SetText("Enable Debug Mode")
    debugCheck:SetChecked(GTD_Settings.debugMode)
    debugCheck:SetScript("OnClick", function(self)
        GTD_Settings.debugMode = self:GetChecked()
        print("|cffffcc00[GTD]:|r Debug Mode " .. (GTD_Settings.debugMode and "Enabled" or "Disabled"))
    end)

    -- Sound Alerts Checkbox
    local soundCheck = CreateFrame("CheckButton", nil, panel, "InterfaceOptionsCheckButtonTemplate")
    soundCheck:SetPoint("TOPLEFT", debugCheck, "BOTTOMLEFT", 0, -5)
    soundCheck.Text:SetText("Enable Sound Alerts")
    soundCheck:SetChecked(GTD_Settings.soundEnabled)
    soundCheck:SetScript("OnClick", function(self)
        GTD_Settings.soundEnabled = self:GetChecked()
        print("|cffffcc00[GTD]:|r Sound Alerts " .. (GTD_Settings.soundEnabled and "Enabled" or "Disabled"))
    end)

    -- Chat Output Dropdown
    local chatOptions = { "RAID_WARNING", "SAY", "YELL", "PARTY", "GUILD" }
    local dropdown = CreateFrame("Frame", nil, panel, "UIDropDownMenuTemplate")
    dropdown:SetPoint("TOPLEFT", soundCheck, "BOTTOMLEFT", -15, -10)

    local function OnSelect(self, arg1)
        GTD_Settings.chatOutput = arg1
        UIDropDownMenu_SetText(dropdown, "Chat Output: " .. arg1)
        print("|cffffcc00[GTD]:|r Chat alerts now appear in " .. arg1)
    end

    UIDropDownMenu_SetWidth(dropdown, 150)
    UIDropDownMenu_SetText(dropdown, "Chat Output: " .. GTD_Settings.chatOutput)
    UIDropDownMenu_Initialize(dropdown, function(self, level, menuList)
        for _, chatType in ipairs(chatOptions) do
            local info = UIDropDownMenu_CreateInfo()
            info.text = chatType
            info.arg1 = chatType
            info.func = OnSelect
            info.checked = (GTD_Settings.chatOutput == chatType)
            UIDropDownMenu_AddButton(info)
        end
    end)

    -- Register panel in WoW's Interface Options
    InterfaceOptions_AddCategory(panel)
end

-- Hook the settings to load when the addon is initialized
GTD_LoadSettings()
GTD_CreateSettingsMenu()
