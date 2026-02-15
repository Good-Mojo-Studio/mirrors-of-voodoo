-- some variables --
VDW.MOV = VDW.MOV or {}
local G = VDW.Local.Override
local C = VDW.GetAddonColors("MOV")
local prefixTip = VDW.Prefix("MOV")
local prefixChat = VDW.PrefixChat("MOV")
local function CreateGlobalVariables()
-- function for opening the options --
	local function ShowMenu()
		if not InCombatLockdown() then
			local _, loaded = C_AddOns.IsAddOnLoaded("MOV_Options")
			local loadable, reason = C_AddOns.IsAddOnLoadable("MOV_Options" , nil , true)
			if reason == "MISSING" then
				C_Sound.PlayVocalErrorSound(48)
				DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..string.format(G.WRN_ADDON_IS_STATE, C.High:WrapTextInColorCode("Mirrors of Voodoo Options"), reason)))
				UIErrorsFrame:AddExternalWarningMessage(string.format(G.WRN_ADDON_IS_STATE, C.High:WrapTextInColorCode("Mirrors of Voodoo Options"), reason))
			elseif loadable and not loaded then
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
				C_Sound.PlayVocalErrorSound(48)
				DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..string.format(G.WRN_ADDON_IS_STATE, C_AddOns.GetAddOnMetadata("MOV_Options", "Title"), reason)))
				UIErrorsFrame:AddExternalWarningMessage(string.format(G.WRN_ADDON_IS_STATE, C_AddOns.GetAddOnMetadata("MOV_Options", "Title"), reason))
			end
		else
			C_Sound.PlayVocalErrorSound(48)
			DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..G.WRN_COMBAT_LOCKDOWN))
			UIErrorsFrame:AddExternalWarningMessage(G.WRN_COMBAT_LOCKDOWN)
		end
	end
-- slash command --
	RegisterNewSlashCommand(ShowMenu, "mov", "mirrorsofvoodoo2")
-- mini map Button Functions --
	AddonCompartmentFrame:RegisterAddon({
		text = C.Main:WrapTextInColorCode(C_AddOns.GetAddOnMetadata("MOV", "Title")),
		icon = C_AddOns.GetAddOnMetadata("MOV", "IconAtlas"),
		notCheckable = true,
		func = function(button, menuInputData, menu)
			local buttonName = menuInputData.buttonName
			if buttonName == "LeftButton" then
				ShowMenu()
			end
		end,
		funcOnEnter = function(button)
			MenuUtil.ShowTooltip(button, function(tooltip)
			tooltip:SetOwner(AddonCompartmentFrame, "ANCHOR_TOP", 0, 0)
			tooltip:SetText(C.Main:WrapTextInColorCode(prefixTip).."|n"..G.BUTTON_L_CLICK..": "..G.TIP_OPEN_SETTINGS_MAIN)
			end)
		end,
		funcOnLeave = function(button)
			MenuUtil.HideTooltip(AddonCompartmentFrame)
		end,
	})
end
-- loading first time the variables --
local function FirstTimeSavedVariables()
	if MOVprofiles == nil then MOVprofiles = {} end
	if MOVsettings == nil then
		MOVsettings = {
			NameText = {Position = G.OPTIONS_P_BOTTOMLEFT},
			TimeText = {Position = G.OPTIONS_P_BOTTOMRIGHT},
		}
	end
	if MOVspecialSettings == nil then MOVspecialSettings = {} end
	if MOVspecialSettings["LastLocation"] == nil then
		MOVspecialSettings["LastLocation"] = GetLocale()
	end
end
-- protect the options --
local function ProtectOptions()
	local loc = GetLocale()
	if loc ~= MOVspecialSettings["LastLocation"] then
		for k, v in pairs(VDW.Local.Translate) do
			for i, s in pairs (v) do
				if MOVsettings["NameText"]["Position"] == s then
					MOVsettings["NameText"]["Position"] = VDW.Local.Translate[loc][i]
				end
				if MOVsettings["TimeText"]["Position"] == s then
					MOVsettings["TimeText"]["Position"] = VDW.Local.Translate[loc][i]
				end
			end
		end
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
	if MOVsettings[var1]["Position"] == G.OPTIONS_P_TOPLEFT then
		var2:ClearAllPoints()
		var2:SetPoint("BOTTOMLEFT", self, "TOPLEFT", 8, 0)
		if not var2:IsShown() then var2:Show() end
	elseif MOVsettings[var1]["Position"] == G.OPTIONS_P_LEFT then
		var2:ClearAllPoints()
		var2:SetPoint("LEFT", self, "LEFT", 8, 6)
		if not var2:IsShown() then var2:Show() end
	elseif MOVsettings[var1]["Position"] == G.OPTIONS_P_BOTTOMLEFT then
		var2:ClearAllPoints()
		var2:SetPoint("TOPLEFT", self, "BOTTOMLEFT", 8, 15)
		if not var2:IsShown() then var2:Show() end
	elseif MOVsettings[var1]["Position"] == G.OPTIONS_P_TOP then
		var2:ClearAllPoints()
		var2:SetPoint("BOTTOM", self, "TOP", 0, 0)
		if not var2:IsShown() then var2:Show() end
	elseif MOVsettings[var1]["Position"] == G.OPTIONS_P_CENTER then
		var2:ClearAllPoints()
		var2:SetPoint("CENTER", self, "CENTER", 0, 6)
		if not var2:IsShown() then var2:Show() end
	elseif MOVsettings[var1]["Position"] == G.OPTIONS_P_BOTTOM then
		var2:ClearAllPoints()
		var2:SetPoint("TOP", self, "BOTTOM", 0, 15)
		if not var2:IsShown() then var2:Show() end
	elseif MOVsettings[var1]["Position"] == G.OPTIONS_P_TOPRIGHT then
		var2:ClearAllPoints()
		var2:SetPoint("BOTTOMRIGHT", self, "TOPRIGHT", -8, 0)
		if not var2:IsShown() then var2:Show() end
	elseif MOVsettings[var1]["Position"] == G.OPTIONS_P_RIGHT then
		var2:ClearAllPoints()
		var2:SetPoint("RIGHT", self, "RIGHT", -8, 6)
		if not var2:IsShown() then var2:Show() end
	elseif MOVsettings[var1]["Position"] == G.OPTIONS_P_BOTTOMRIGHT then
		var2:ClearAllPoints()
		var2:SetPoint("TOPRIGHT", self, "BOTTOMRIGHT", -8, 15)
		if not var2:IsShown() then var2:Show() end
	elseif MOVsettings[var1]["Position"] == G.OPTIONS_V_HIDE then
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
		ProtectOptions()
		MOVspecialSettings["LastLocation"] = GetLocale()
	end
end
movZlave:SetScript("OnEvent", EventsTime)
