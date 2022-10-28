-- rVignette: core
-- zork, 2018
-- Neav (fix)
-- Shamelessly stolen by Howl

-----------------------------
-- Variables
-----------------------------

local A, L = ...

-----------------------------
-- Functions
-----------------------------

local function OnVignetteAdded(self,event,id)
  if not id then return end
  self.vignettes = self.vignettes or {}
  if self.vignettes[id] then return end
  local vignetteInfo = C_VignetteInfo.GetVignetteInfo(id)
  if not vignetteInfo then return end
  --[[local filename, width, height, txLeft, txRight, txTop, txBottom = C_Texture.GetAtlasInfo(vignetteInfo.atlasName)
  if not filename then return end
  local atlasWidth = width/(txRight-txLeft)
  local atlasHeight = height/(txBottom-txTop)
  ]] -- Old stuff from Zork
  
  -- Adding fix from Neav
  local atlasInfo = C_Texture.GetAtlasInfo(vignetteInfo.atlasName)
  local left = atlasInfo.leftTexCoord * 256
  local right = atlasInfo.rightTexCoord * 256
  local top = atlasInfo.topTexCoord * 256
  local bottom = atlasInfo.bottomTexCoord * 256
  local str = "|TInterface\\MINIMAP\\ObjectIconsAtlas:0:0:0:0:256:256:"..(left)..":"..(right)..":"..(top)..":"..(bottom).."|t"
  -- More old stuff
  --local str = string.format("|T%s:%d:%d:0:0:%d:%d:%d:%d:%d:%d|t", filename, 0, 0, atlasWidth, atlasHeight, atlasWidth*txLeft, atlasWidth*txRight, atlasHeight*txTop, atlasHeight*txBottom)
  --PlaySoundFile("Sound\\Interface\\RaidWarning.ogg") -- Deprecated
  PlaySoundFile(567397) 
  
  
  if vignetteInfo.name ~= "Garrison Cache" and vignetteInfo.name ~= "Full Garrison Cache" and vignetteInfo.name ~= nil then
  RaidNotice_AddMessage(RaidWarningFrame, str.." "..vignetteInfo.name.." spotted!", ChatTypeInfo["RAID_WARNING"])
  print(str.." "..vignetteInfo.name,"spotted!")
  self.vignettes[id] = true
   
end
end

-----------------------------
-- Init
-----------------------------

--eventHandler
local eventHandler = CreateFrame("Frame")
eventHandler:RegisterEvent("VIGNETTE_MINIMAP_UPDATED")
eventHandler:SetScript("OnEvent", OnVignetteAdded)