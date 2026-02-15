-- some variables --
local L = VDW.MOV.Local
local C = VDW.GetAddonColors("MOV")
local prefixTip = VDW.Prefix("MOV")
local maxW = 128
local finalW = 0
-- Entering the tabs frame' Exit Button --
movOptions00.ExitButton:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.TIP_CLOSE_PANEL, C.Main)
end)
-- Move the tabs frame --
movOptions00:RegisterForDrag("LeftButton")
movOptions00:SetScript("OnDragStart", movOptions00.StartMoving)
movOptions00:SetScript("OnDragStop", movOptions00.StopMovingOrSizing)
-- Taking care of the Tabs --
-- Naming the tab --
movOptions00Tab1.Text:SetText(L.T_NAME_TIMERS)
movOptions00Tab2.Text:SetText(L.P_TAB)
-- Position & center text color --
for i = 1, 2, 1 do
	local w = _G["movOptions00Tab"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 16)
for i = 1, 2, 1 do
	_G["movOptions00Tab"..i]:SetWidth(finalW)
end
movOptions00Tab2:SetPoint("TOP", movOptions00Tab1, "BOTTOM", 0, 0)
-- Entering the tabs --
movOptions00Tab1:HookScript("OnEnter", function(self)
	local word = self.Text:GetText()
	VDW.Tooltip_Show(self, prefixTip, string.format(L.T_TIP, word), C.Main)
end)
movOptions00Tab2:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.P_TITLE, C.Main)
end)
-- Leaving the tabs --
for i = 1, 2, 1 do
	_G["movOptions00Tab"..i]:HookScript("OnLeave", function(self)
		VDW.Tooltip_Hide()
	end)
end
-- clickingthe tabs --
for i = 1, 2, 1 do
	_G["movOptions00Tab"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			if not _G["movOptions"..i]:IsShown() then _G["movOptions"..i]:Show() end
		end
	end)
end
-- show the tabs frame --
movOptions00:SetScript("OnShow", function(self)
	if not movOptions1:IsShown() then movOptions1:Show() end
end)
-- Hide the tabs frame --
movOptions00:HookScript("OnHide", function(self)
	if movOptions1:IsShown() then movOptions1:Hide() end
	if movOptions2:IsShown() then movOptions2:Hide() end
end)
