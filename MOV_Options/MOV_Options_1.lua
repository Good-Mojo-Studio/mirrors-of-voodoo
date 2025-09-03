-- taking care of the panel --
movOptions1.TopTxt:SetText("Position of the Name and Time!")
-- naming the boxes --
movOptions1Box1.TitleTxt:SetText("Position of the Name and Time")
-- Checking the Saved Variables --
local function CheckSavedVariables()
	movOptions1Box1PopOut1:SetText(MOVplayer["NameText"]["Position"])
	movOptions1Box1PopOut2:SetText(MOVplayer["TimeText"]["Position"])
end
-- Box 1 Position of Name and Time --
-- pop out 1 Name's Position --
-- drop down --
movClickPopOut(movOptions1Box1PopOut1, movOptions1Box1PopOut1Choice0)
-- enter --
movOptions1Box1PopOut1:SetScript("OnEnter", function(self)
	movEnteringMenus(self)
	GameTooltip:SetText(movMainColor:WrapTextInColorCode("|A:"..C_AddOns.GetAddOnMetadata("MOV", "IconAtlas")..":16:16|a "..C_AddOns.GetAddOnMetadata("MOV", "Title")).."|nWhere do you want the|nMirror's name to be shown?") 
end)
-- leave --
movOptions1Box1PopOut1:SetScript("OnLeave", movLeavingMenus)
-- naming --
movOptions1Box1PopOut1Choice0.Text:SetText("Hide")
movOptions1Box1PopOut1Choice1.Text:SetText("Top Left")
movOptions1Box1PopOut1Choice2.Text:SetText("Left")
movOptions1Box1PopOut1Choice3.Text:SetText("Bottom Left")
movOptions1Box1PopOut1Choice4.Text:SetText("Top")
movOptions1Box1PopOut1Choice5.Text:SetText("Center")
movOptions1Box1PopOut1Choice6.Text:SetText("Bottom")
movOptions1Box1PopOut1Choice7.Text:SetText("Top Right")
movOptions1Box1PopOut1Choice8.Text:SetText("Right")
movOptions1Box1PopOut1Choice9.Text:SetText("Bottom Right")
-- parent & sort --
for i = 1, 9, 1 do
	_G["movOptions1Box1PopOut1Choice"..i]:SetParent(movOptions1Box1PopOut1Choice0)
	_G["movOptions1Box1PopOut1Choice"..i]:SetPoint("TOP", _G["movOptions1Box1PopOut1Choice"..i-1], "BOTTOM", 0, 0)
end
-- clicking --
for i = 0, 9, 1 do
	_G["movOptions1Box1PopOut1Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			MOVplayer["NameText"]["Position"] = self.Text:GetText()
			movOptions1Box1PopOut1.Text:SetText(self.Text:GetText())
			movOptions1Box1PopOut1Choice0:Hide()
		end
	end)
end
-- pop out 2 Spell's Name --
-- drop down --
movClickPopOut(movOptions1Box1PopOut2, movOptions1Box1PopOut2Choice0)
-- enter --
movOptions1Box1PopOut2:SetScript("OnEnter", function(self)
	movEnteringMenus(self)
	GameTooltip:SetText(movMainColor:WrapTextInColorCode("|A:"..C_AddOns.GetAddOnMetadata("MOV", "IconAtlas")..":16:16|a "..C_AddOns.GetAddOnMetadata("MOV", "Title")).."|nWhere do you want the|nMirror's time to be shown?") 
end)
-- leave --
movOptions1Box1PopOut2:SetScript("OnLeave", movLeavingMenus)
-- naming --
movOptions1Box1PopOut2Choice0.Text:SetText("Hide")
movOptions1Box1PopOut2Choice1.Text:SetText("Top Left")
movOptions1Box1PopOut2Choice2.Text:SetText("Left")
movOptions1Box1PopOut2Choice3.Text:SetText("Bottom Left")
movOptions1Box1PopOut2Choice4.Text:SetText("Top")
movOptions1Box1PopOut2Choice5.Text:SetText("Center")
movOptions1Box1PopOut2Choice6.Text:SetText("Bottom")
movOptions1Box1PopOut2Choice7.Text:SetText("Top Right")
movOptions1Box1PopOut2Choice8.Text:SetText("Right")
movOptions1Box1PopOut2Choice9.Text:SetText("Bottom Right")
-- parent & sort --
for i = 1, 9, 1 do
	_G["movOptions1Box1PopOut2Choice"..i]:SetParent(movOptions1Box1PopOut2Choice0)
	_G["movOptions1Box1PopOut2Choice"..i]:SetPoint("TOP", _G["movOptions1Box1PopOut2Choice"..i-1], "BOTTOM", 0, 0)
end
-- clicking --
for i = 0, 9, 1 do
	_G["movOptions1Box1PopOut2Choice"..i]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			MOVplayer["TimeText"]["Position"] = self.Text:GetText()
			movOptions1Box1PopOut2.Text:SetText(self.Text:GetText())
			movOptions1Box1PopOut2Choice0:Hide()
		end
	end)
end
-- Showing the panel --
movOptions1:HookScript("OnShow", function(self)
	CheckSavedVariables()
	if movOptions2:IsShown() then movOptions2:Hide() end
	movOptions00Tab1.Text:SetTextColor(movHighColor:GetRGB())
	movOptions00Tab2.Text:SetTextColor(movMainColor:GetRGB())
end)
