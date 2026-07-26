-- Some variables
local Color = VDW.GetAddonColors("MOV")
local prefixTip = VDW.Prefix("MOV")
local maxW = 128
local finalW = 0
-- Create panel
movOptions.ExitButton:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.CLOSE_THIS_PANEL, Color.Main, "Left")
end)
VDW.MoveTheFrame(movOptions, "LeftButton")
movOptions.Tab1.Text:SetText(VDWtranslate.Global.NAME.." - "..VDWtranslate.Global.TIME)
movOptions.Tab2.Text:SetText(VDWtranslate.Global.P_TAB)
for i = 1, 2, 1 do
	local w = movOptions["Tab"..i].Text:GetStringWidth()
	if w > maxW then maxW = w end
end
finalW = math.ceil(maxW + 16)
for i = 1, 2, 1 do
	movOptions["Tab"..i]:SetWidth(finalW)
	movOptions["Tab"..i].NormalTexture:SetVertexColor(Color.High:GetRGB())
	movOptions["Tab"..i]:HookScript("OnLeave", function(self)
		VDW.Tooltip_Hide()
	end)
	movOptions["Tab"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			if not movOptions["Panel"..i]:IsShown() then movOptions["Panel"..i]:Show() end
		end
	end)
	if i == 1 then
		movOptions["Tab"..i]:HookScript("OnEnter", function(self)
			local word = self.Text:GetText()
			VDW.Tooltip_Show(self, prefixTip, string.format(VDWtranslate.Global.OPTIONS_FOR, word), Color.Main, "Left")
		end)
	else
		movOptions["Tab"..i]:SetPoint("TOP", movOptions["Tab"..i-1], "BOTTOM", 0, 0)
		movOptions["Tab"..i]:HookScript("OnEnter", function(self)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.P_TITLE, Color.Main, "Left")
		end)
	end
end
-- Show the option panel
movOptions:SetScript("OnShow", function(self)
	if not movOptions.Panel1:IsShown() then movOptions.Panel1:Show() end
end)
-- Hide the option panel
movOptions:HookScript("OnHide", function(self)
	for i = 1, 2, 1 do
		if movOptions["Panel"..i]:IsShown() then movOptions["Panel"..i]:Hide() end
	end
end)
