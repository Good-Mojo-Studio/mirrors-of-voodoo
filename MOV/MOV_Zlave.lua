-- create some global variables --
local function CreateGlobalVariables()
-- Colors --
	movMainColor = CreateColorFromRGBAHexString("F0E68CFF")
	movHighColor = CreateColorFromRGBAHexString("C04000FF")
	movNoMainColor = CreateColorFromRGBAHexString("F0E68C00")
	movNoHighColor = CreateColorFromRGBAHexString("C0400000")
-- function for showing the menu --
	local function movShowMenu()
		if not InCombatLockdown() then
			local _, loaded = C_AddOns.IsAddOnLoaded("MOV_Options")
			local loadable, reason = C_AddOns.IsAddOnLoadable("MOV_Options" , nil , true)
			if loadable and not loaded then
				C_AddOns.LoadAddOn("MOV_Options")
				if not movOptions00:IsShown() then
					movOptions00:Show()
				else
					movOptions00:Hide()
				end
			elseif loadable and loaded then
				if not movOptions00:IsShown() then
					movOptions00:Show()
				else
					movOptions00:Hide()
				end
			else
				local movTime = GameTime_GetTime(false)
				DEFAULT_CHAT_FRAME:AddMessage(movTime.." |A:"..C_AddOns.GetAddOnMetadata("MOV", "IconAtlas")..":16:16|a ["..movMainColor:WrapTextInColorCode(C_AddOns.GetAddOnMetadata("MOV", "Title")).."] The addon with the name "..movMainColor:WrapTextInColorCode(C_AddOns.GetAddOnMetadata("MOV_Options", "Title")).." is "..reason.."!")
			end
		else
			local movTime = GameTime_GetTime(false)
			DEFAULT_CHAT_FRAME:AddMessage(movTime.." |A:"..C_AddOns.GetAddOnMetadata("MOV", "IconAtlas")..":16:16|a ["..movMainColor:WrapTextInColorCode(C_AddOns.GetAddOnMetadata("MOV", "Title")).."] While you are in combat, you can't do this!")
		end
	end
-- Slash Command --
	RegisterNewSlashCommand(movShowMenu, "mov", "mirrorsofvoodoo")
-- Mini Map Button Functions --
	AddonCompartmentFrame:RegisterAddon({
		text = movMainColor:WrapTextInColorCode(C_AddOns.GetAddOnMetadata("MOV", "Title")),
		icon = C_AddOns.GetAddOnMetadata("MOV", "IconAtlas"),
		notCheckable = true,
		func = function(button, menuInputData, menu)
			local buttonName = menuInputData.buttonName
			if buttonName == "LeftButton" then
				movShowMenu()
			end
		end,
		funcOnEnter = function(button)
			MenuUtil.ShowTooltip(button, function(tooltip)
			tooltip:SetText("|A:"..C_AddOns.GetAddOnMetadata("MOV", "IconAtlas")..":16:16|a "..movMainColor:WrapTextInColorCode(C_AddOns.GetAddOnMetadata("MOV", "Title")).."|nLeft Click: "..movMainColor:WrapTextInColorCode("Open the main panel of settings!"))
			end)
		end,
		funcOnLeave = function(button)
			MenuUtil.HideTooltip(button)
		end,
	})
end
-- First time saved variable function --
local function FirstTimeSavedVariables()
	if MOVcounterLoading == nil or MOVcounterLoading ~= nil then MOVcounterLoading = 0 end
	if MOVcounterDeleting == nil or MOVcounterDeleting ~= nil then MOVcounterDeleting = 0 end
	if MOVprofile == nil then MOVprofile = {} end
	if MOVnumber == nil then MOVnumber = 0 end
	if MOVplayer == nil then
		MOVplayer = {NameText = {Position = "Bottom Left"},
			TimeText = {Position = "Bottom Right"},
		}
	end
end
-- Time Text for MirrorTimerContainer.mirrorTimers[1] --
local MOVtimeText1 = MirrorTimerContainer.mirrorTimers[1]:CreateFontString(nil, "OVERLAY", nil)
MOVtimeText1:SetFontObject("GameFontHighlightSmall")
-- Name Text for MirrorTimerContainer.mirrorTimers[1] --
local MOVnameText1 = MirrorTimerContainer.mirrorTimers[1]:CreateFontString(nil, "OVERLAY", nil)
MOVnameText1:SetFontObject("GameFontHighlightSmall")
-- Time Text for MirrorTimerContainer.mirrorTimers[2] --
local MOVtimeText2 = MirrorTimerContainer.mirrorTimers[2]:CreateFontString(nil, "OVERLAY", nil)
MOVtimeText2:SetFontObject("GameFontHighlightSmall")
-- Name Text for MirrorTimerContainer.mirrorTimers[2] --
local MOVnameText2 = MirrorTimerContainer.mirrorTimers[2]:CreateFontString(nil, "OVERLAY", nil)
MOVnameText2:SetFontObject("GameFontHighlightSmall")
-- Time Text for MirrorTimerContainer.mirrorTimers[3] --
local MOVtimeText3 = MirrorTimerContainer.mirrorTimers[3]:CreateFontString(nil, "OVERLAY", nil)
MOVtimeText3:SetFontObject("GameFontHighlightSmall")
-- Name Text for MirrorTimerContainer.mirrorTimers[3] --
local MOVnameText3 = MirrorTimerContainer.mirrorTimers[3]:CreateFontString(nil, "OVERLAY", nil)
MOVnameText3:SetFontObject("GameFontHighlightSmall")
-- Function for Time --
local function CalculateShowTime(var1, txt)
	local seconds = mod (var1, 60)
	local minutes = mod (floor (floor(var1) / 60), 60)
	if minutes == 0 then
		txt:SetFormattedText("%.2f", seconds)
	else
		txt:SetFormattedText(minutes.. ":".. "%.0f", seconds)
	end
end
-- Postion function for the timers --
local function Positioning(self , var1, var2)
	if MOVplayer[var1]["Position"] == "Top Left" then
		var2:ClearAllPoints()
		var2:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 8, 0)
		if not var2:IsShown() then var2:Show() end
	elseif MOVplayer[var1]["Position"] == "Left" then
		var2:ClearAllPoints()
		var2:SetPoint("LEFT", self, "LEFT", 8, 6)
		if not var2:IsShown() then var2:Show() end
	elseif MOVplayer[var1]["Position"] == "Bottom Left" then
		var2:ClearAllPoints()
		var2:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 8, 15)
		if not var2:IsShown() then var2:Show() end
	elseif MOVplayer[var1]["Position"] == "Top" then
		var2:ClearAllPoints()
		var2:SetPoint("BOTTOM", self, "TOP", 0, 0)
		if not var2:IsShown() then var2:Show() end
	elseif MOVplayer[var1]["Position"] == "Center" then
		var2:ClearAllPoints()
		var2:SetPoint("CENTER", self, "CENTER", 0, 6)
		if not var2:IsShown() then var2:Show() end
	elseif MOVplayer[var1]["Position"] == "Bottom" then
		var2:ClearAllPoints()
		var2:SetPoint("TOP", self, "BOTTOM", 0, 15)
		if not var2:IsShown() then var2:Show() end
	elseif MOVplayer[var1]["Position"] == "Top Right" then
		var2:ClearAllPoints()
		var2:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -8, 0)
		if not var2:IsShown() then var2:Show() end
	elseif MOVplayer[var1]["Position"] == "Right" then
		var2:ClearAllPoints()
		var2:SetPoint("RIGHT", self, "RIGHT", -8, 6)
		if not var2:IsShown() then var2:Show() end
	elseif MOVplayer[var1]["Position"] == "Bottom Right" then
		var2:ClearAllPoints()
		var2:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", -8, 15)
		if not var2:IsShown() then var2:Show() end
	elseif MOVplayer[var1]["Position"] == "Hide" then
		var2:Hide()
	end
end
-- Hooking Time part 1 --
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
-- Hooking Time part 2 --
MirrorTimerContainer.mirrorTimers[1]["StatusBar"]:HookScript("OnUpdate", function(self)
	CalculateShowTime(self:GetValue(), MOVtimeText1)
end)
MirrorTimerContainer.mirrorTimers[2]["StatusBar"]:HookScript("OnUpdate", function(self)
	CalculateShowTime(self:GetValue(), MOVtimeText2)
end)
MirrorTimerContainer.mirrorTimers[3]["StatusBar"]:HookScript("OnUpdate", function(self)
	CalculateShowTime(self:GetValue(), MOVtimeText3)
end)
-- Events Time --
local function EventsTime(self, event, arg1, arg2, arg3)
	if event == "PLAYER_LOGIN" then
		CreateGlobalVariables()
		FirstTimeSavedVariables()
	end
end
movZlave:SetScript("OnEvent", EventsTime)
