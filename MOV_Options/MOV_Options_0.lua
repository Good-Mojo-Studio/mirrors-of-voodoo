-- Move the Tabs --
movOptions00:RegisterForDrag("LeftButton")
movOptions00:SetScript("OnDragStart", movOptions00.StartMoving)
movOptions00:SetScript("OnDragStop", movOptions00.StopMovingOrSizing)
-- taking care of the Tabs --
-- position --
movOptions00Tab2:SetPoint("TOP", movOptions00Tab1, "BOTTOM", 0, 0)
-- naming --
movOptions00Tab1.Text:SetText("Positions")
movOptions00Tab2.Text:SetText("Profiles")
-- hiding the center text --
movOptions00Tab1.CenterTxt:Hide()
-- dimensions and welcome text --
movOptions00Tab2.CenterTxt:SetText("Thank you for using this amazing add-on!|nYou are a |cff00CED1Funky|r and a |cffFF0055Groovy|r person!|nMay the good |cff9400D3Mojo|r be with you!")
movOptions00.BGtexture:SetGradient("VERTICAL", movNoMainColor, movMainColor)
movOptions00.BGtexture:ClearAllPoints()
movOptions00.BGtexture:SetPoint("TOPRIGHT", movOptions00, "TOPRIGHT", 0, 0)
movOptions00.BGtexture:SetPoint("BOTTOMLEFT", movOptions00Tab2, "BOTTOMLEFT", 0, -128)
-- clicking on the tabs --
for i = 1, 2, 1 do
	_G["movOptions00Tab"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			if not _G["movOptions"..i]:IsShown() then _G["movOptions"..i]:Show() end
		end
	end)
end
-- showing the tabs --
movOptions00:SetScript("OnShow", function(self)
	if not movOptions1:IsShown() then movOptions1:Show() end
end)
-- hiding the tabs --
movOptions00:HookScript("OnHide", function(self)
	for i = 1, 2, 1 do
		if _G["movOptions"..i]:IsShown() then _G["movOptions"..i]:Hide() end
	end
end)
