-- Debugging System for Gnomish Treasure Detector
DebugMode = false  -- Set to true to enable debugging

local function DebugPrint(...)
    if DebugMode then
        print("|cffffcc00[GTD Debug]:|r", ...)
    end
end

-- Function to log errors safely
local function SafeCall(func, ...)
    local success, result = pcall(func, ...)
    if not success then
        print("|cffff0000[GTD Error]:|r", result)
    end
    return success, result
end

-- Slash command to toggle debug mode in-game
SLASH_GTDEBUG1 = "/gtdebug"
SlashCmdList["GTDEBUG"] = function(msg)
    DebugMode = not DebugMode
    print("|cffffcc00[GTD Debug Mode]:|r", DebugMode and "Enabled" or "Disabled")
end

-- Make functions available for other files
GTD_Debug = {
    Print = DebugPrint,
    SafeCall = SafeCall
}
