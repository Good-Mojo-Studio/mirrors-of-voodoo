-- Some variables
MOV = MOV or {}
local Color = VDW.GetAddonColors("MOV")
-- First time variables
local function FirstTimeSavedVariables()
	if MOVprofiles == nil then MOVprofiles = {} end
	if MOVsettings == nil then MOVsettings = {} end
	if MOVsettings.NameText == nil then MOVsettings.NameText = {Position = "BottomLeft"} end
	if MOVsettings.TimeText == nil then MOVsettings.TimeText = {Position = "BottomRight"} end
	if MOVspecialSettings then MOVspecialSettings = nil end
end
-- Time for MirrorTimerContainer.mirrorTimers[1]
local MOVtimeText1 = MirrorTimerContainer.mirrorTimers[1]:CreateFontString(nil, "OVERLAY", nil)
MOVtimeText1:SetFontObject("GameFontHighlightSmall")
-- Name for MirrorTimerContainer.mirrorTimers[1]
local MOVnameText1 = MirrorTimerContainer.mirrorTimers[1]:CreateFontString(nil, "OVERLAY", nil)
MOVnameText1:SetFontObject("GameFontHighlightSmall")
-- Time for MirrorTimerContainer.mirrorTimers[2]
local MOVtimeText2 = MirrorTimerContainer.mirrorTimers[2]:CreateFontString(nil, "OVERLAY", nil)
MOVtimeText2:SetFontObject("GameFontHighlightSmall")
-- Name for MirrorTimerContainer.mirrorTimers[2]
local MOVnameText2 = MirrorTimerContainer.mirrorTimers[2]:CreateFontString(nil, "OVERLAY", nil)
MOVnameText2:SetFontObject("GameFontHighlightSmall")
-- Time for MirrorTimerContainer.mirrorTimers[3]
local MOVtimeText3 = MirrorTimerContainer.mirrorTimers[3]:CreateFontString(nil, "OVERLAY", nil)
MOVtimeText3:SetFontObject("GameFontHighlightSmall")
-- Name for MirrorTimerContainer.mirrorTimers[3]
local MOVnameText3 = MirrorTimerContainer.mirrorTimers[3]:CreateFontString(nil, "OVERLAY", nil)
MOVnameText3:SetFontObject("GameFontHighlightSmall")
-- Calculate time
local function CalculateTime(var1, txt)
	local seconds = mod (var1, 60)
	local minutes = mod (floor (floor(var1) / 60), 60)
	if minutes == 0 then
		txt:SetFormattedText("%.2f Sec", seconds)
	else
		if seconds >= 10 then
			txt:SetFormattedText(minutes..":".."%.0f", seconds)
		else
			txt:SetFormattedText(minutes..":0".."%.0f", seconds)
		end
	end
end
-- Positioning time
local function Positioning(self , var1, var2)
	if MOVsettings[var1].Position == "TopLeft" then
		var2:ClearAllPoints()
		var2:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 8, 0)
		if not var2:IsShown() then var2:Show() end
	elseif MOVsettings[var1].Position == "Left" then
		var2:ClearAllPoints()
		var2:SetPoint("LEFT", self, "LEFT", 8, 6)
		if not var2:IsShown() then var2:Show() end
	elseif MOVsettings[var1].Position == "BottomLeft" then
		var2:ClearAllPoints()
		var2:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 8, 15)
		if not var2:IsShown() then var2:Show() end
	elseif MOVsettings[var1].Position == "Top" then
		var2:ClearAllPoints()
		var2:SetPoint("BOTTOM", self, "TOP", 0, 0)
		if not var2:IsShown() then var2:Show() end
	elseif MOVsettings[var1].Position == "Center" then
		var2:ClearAllPoints()
		var2:SetPoint("CENTER", self, "CENTER", 0, 6)
		if not var2:IsShown() then var2:Show() end
	elseif MOVsettings[var1].Position == "Bottom" then
		var2:ClearAllPoints()
		var2:SetPoint("TOP", self, "BOTTOM", 0, 15)
		if not var2:IsShown() then var2:Show() end
	elseif MOVsettings[var1].Position == "TopRight" then
		var2:ClearAllPoints()
		var2:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -8, 0)
		if not var2:IsShown() then var2:Show() end
	elseif MOVsettings[var1].Position == "Right" then
		var2:ClearAllPoints()
		var2:SetPoint("RIGHT", self, "RIGHT", -8, 6)
		if not var2:IsShown() then var2:Show() end
	elseif MOVsettings[var1].Position == "BottomRight" then
		var2:ClearAllPoints()
		var2:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", -8, 15)
		if not var2:IsShown() then var2:Show() end
	elseif MOVsettings[var1].Position == "Hide" then
		var2:Hide()
	end
end
-- Hooking time part 1
MirrorTimerContainer.mirrorTimers[1]:HookScript("OnShow", function(self)
	self.Text:SetAlpha(0)
	Positioning(self , "NameText", MOVnameText1)
	MOVnameText1:SetText(self.Text:GetText())
	Positioning(self , "TimeText", MOVtimeText1)
end)
MirrorTimerContainer.mirrorTimers[2]:HookScript("OnShow", function(self)
	self.Text:SetAlpha(0)
	Positioning(self , "NameText", MOVnameText2)
	MOVnameText2:SetText(self.Text:GetText())
	Positioning(self , "TimeText", MOVtimeText2)
end)
MirrorTimerContainer.mirrorTimers[3]:HookScript("OnShow", function(self)
	self.Text:SetAlpha(0)
	Positioning(self , "NameText", MOVnameText3)
	MOVnameText3:SetText(self.Text:GetText())
	Positioning(self , "TimeText", MOVtimeText3)
end)
-- Hooking time part 2
MirrorTimerContainer.mirrorTimers[1]["StatusBar"]:HookScript("OnUpdate", function(self)
	CalculateTime(self:GetValue(), MOVtimeText1)
end)
MirrorTimerContainer.mirrorTimers[2]["StatusBar"]:HookScript("OnUpdate", function(self)
	CalculateTime(self:GetValue(), MOVtimeText2)
end)
MirrorTimerContainer.mirrorTimers[3]["StatusBar"]:HookScript("OnUpdate", function(self)
	CalculateTime(self:GetValue(), MOVtimeText3)
end)
-- Events time
local function EventsTime(self, event, arg1, arg2, arg3)
	if event == "ADDON_LOADED" and arg1 == "MOV" then
		VDW.CreateSlashMinmap("MOV", "MOV_Options", "Mirrors of Voodoo Options", "movOptions", "mov", "mirrorsofvoodoo", Color.Main, Color.High)
		FirstTimeSavedVariables()
	end
end
movZlave:SetScript("OnEvent", EventsTime)
