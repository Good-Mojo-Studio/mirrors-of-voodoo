-- some variables --
local G = VDW.Local.Override
local L = VDW.MOV.Local
local C = VDW.GetAddonColors("MOV")
local prefixTip = VDW.Prefix("MOV")
local maxW = 160
local finalW = 0
local counter = 0
local textPosition = {G.OPTIONS_V_HIDE, G.OPTIONS_P_TOPLEFT, G.OPTIONS_P_LEFT, G.OPTIONS_P_BOTTOMLEFT, G.OPTIONS_P_TOP, G.OPTIONS_P_CENTER, G.OPTIONS_P_BOTTOM, G.OPTIONS_P_TOPRIGHT, G.OPTIONS_P_RIGHT, G.OPTIONS_P_BOTTOMRIGHT}
-- Taking care of the option panel --
movOptions1:ClearAllPoints()
movOptions1:SetPoint("TOPLEFT", movOptions00, "TOPLEFT", 0, 0)
-- Background of the option panel --
movOptions1.BGtexture:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-Achievement-Parchment-Horizontal-Desaturated.blp", "CLAMP", "CLAMP", "NEAREST")
movOptions1.BGtexture:SetVertexColor(C.High:GetRGB())
movOptions1.BGtexture:SetDesaturation(0.3)
-- Title of the option panel --
movOptions1.Title:SetTextColor(C.Main:GetRGB())
movOptions1.Title:SetText(prefixTip.."|nVersion: "..C.High:WrapTextInColorCode(C_AddOns.GetAddOnMetadata("MOV", "Version")))
-- Top text of the option panel --
movOptions1.TopTxt:SetTextColor(C.Main:GetRGB())
movOptions1.TopTxt:SetText(L.P_MIRROR_BARS)
-- Bottom right text of the option panel --
movOptions1.BottomRightTxt:SetTextColor(C.Main:GetRGB())
movOptions1.BottomRightTxt:SetText(C_AddOns.GetAddOnMetadata("MOV", "X-Website"))
-- taking care of the boxes --
movOptions1Box1.Title:SetText(L.B_NAMES)
movOptions1Box2.Title:SetText(L.B_TIMERS)
movOptions1Box2:SetPoint("TOPLEFT", movOptions1Box1, "BOTTOMLEFT", 0, 0)
for i = 1, 2, 1 do
	local tW = _G["movOptions1Box"..i].Title:GetStringWidth()+16
	local W = _G["movOptions1Box"..i]:GetWidth()
	if tW >= W then
		_G["movOptions1Box"..i]:SetWidth(tW)
	end
end
-- Coloring the boxes --
for i = 1, 2, 1 do
	_G["movOptions1Box"..i].Title:SetTextColor(C.Main:GetRGB())
	_G["movOptions1Box"..i].BorderTop:SetVertexColor(C.High:GetRGB())
	_G["movOptions1Box"..i].BorderBottom:SetVertexColor(C.High:GetRGB())
	_G["movOptions1Box"..i].BorderLeft:SetVertexColor(C.High:GetRGB())
	_G["movOptions1Box"..i].BorderRight:SetVertexColor(C.High:GetRGB())
end
-- Coloring the pop out buttons --
local function ColoringPopOutButtons(k, var1)
	_G["movOptions1Box"..k.."PopOut"..var1].Text:SetTextColor(C.Main:GetRGB())
	_G["movOptions1Box"..k.."PopOut"..var1].Title:SetTextColor(C.High:GetRGB())
	_G["movOptions1Box"..k.."PopOut"..var1].NormalTexture:SetVertexColor(C.High:GetRGB())
	_G["movOptions1Box"..k.."PopOut"..var1].HighlightTexture:SetVertexColor(C.Main:GetRGB())
	_G["movOptions1Box"..k.."PopOut"..var1].PushedTexture:SetVertexColor(C.High:GetRGB())
end
-- Pop out 1 Buttons text position  --
for k = 1, 2, 1 do
	_G["movOptions1Box"..k.."PopOut1"].Title:SetText(L.W_POSITION)
	ColoringPopOutButtons(k, 1)
	for i, name in ipairs(textPosition) do
		local btn = CreateFrame("Button", "movOptions1Box"..k.."PopOut1Choice"..i, nil, "vdwPopOutButton")
		_G["movOptions1Box"..k.."PopOut1Choice"..i]:ClearAllPoints()
		if i == 1 then
			_G["movOptions1Box"..k.."PopOut1Choice"..i]:SetParent(_G["movOptions1Box"..k.."PopOut1"])
			_G["movOptions1Box"..k.."PopOut1Choice"..i]:SetPoint("TOP", "movOptions1Box"..k.."PopOut1", "BOTTOM", 0, 4)
			_G["movOptions1Box"..k.."PopOut1Choice"..i]:SetScript("OnShow", function(self)
				self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
				PlaySound(855, "Master")
			end)
			_G["movOptions1Box"..k.."PopOut1Choice"..i]:SetScript("OnHide", function(self)
				self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
				PlaySound(855, "Master")
			end)
		else
			_G["movOptions1Box"..k.."PopOut1Choice"..i]:SetParent(_G["movOptions1Box"..k.."PopOut1Choice1"])
			_G["movOptions1Box"..k.."PopOut1Choice"..i]:SetPoint("TOP", _G["movOptions1Box"..k.."PopOut1Choice"..i-1], "BOTTOM", 0, 0)
			_G["movOptions1Box"..k.."PopOut1Choice"..i]:Show()
		end
		_G["movOptions1Box"..k.."PopOut1Choice"..i].Text:SetText(name)
		_G["movOptions1Box"..k.."PopOut1Choice"..i]:HookScript("OnClick", function(self, button, down)
			if button == "LeftButton" and down == false then
				if k == 1 then
					MOVsettings["NameText"]["Position"] = self.Text:GetText()
				elseif k== 2 then
					MOVsettings["TimeText"]["Position"] = self.Text:GetText()
				end
				_G["movOptions1Box"..k.."PopOut1"].Text:SetText(self.Text:GetText())
				_G["movOptions1Box"..k.."PopOut1Choice1"]:Hide()
			end
		end)
	local w = _G["movOptions1Box"..k.."PopOut1Choice"..i].Text:GetStringWidth()
		if w > maxW then maxW = w end
	end
	finalW = math.ceil(maxW + 24)
	for i = 1, counter, 1 do
		_G["movOptions1Box"..k.."PopOut1Choice"..i]:SetWidth(finalW)
	end
	counter = 0
	maxW = 160
	_G["movOptions1Box"..k.."PopOut1"]:HookScript("OnEnter", function(self)
		local parent = self:GetParent()
		local word = parent.Title:GetText()
		VDW.Tooltip_Show(self, prefixTip, string.format(L.W_P_TIP, word), C.Main)
	end)
	_G["movOptions1Box"..k.."PopOut1"]:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
	_G["movOptions1Box"..k.."PopOut1"]:HookScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			if not _G["movOptions1Box"..k.."PopOut1Choice1"]:IsShown() then
				_G["movOptions1Box"..k.."PopOut1Choice1"]:Show()
			else
				_G["movOptions1Box"..k.."PopOut1Choice1"]:Hide()
			end
		end
	end)
end
-- Checking the Saved Variables --
local function CheckSavedVariables()
	movOptions1Box1PopOut1.Text:SetText(MOVsettings["NameText"]["Position"])
	movOptions1Box2PopOut1.Text:SetText(MOVsettings["TimeText"]["Position"])
end
-- Show the option panel --
movOptions1:HookScript("OnShow", function(self)
	movOptions00Tab2.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	if movOptions2:IsShown() then movOptions2:Hide() end
	movOptions00Tab1.Text:SetTextColor(C.High:GetRGB())
	CheckSavedVariables()
end)
-- Background of the tabs frame --
local OptionsW = movOptions1:GetWidth()
movOptions00:SetWidth(movOptions00Tab1:GetWidth() + OptionsW)
movOptions00:SetHeight(movOptions1:GetHeight())
movOptions00.BGtexture:ClearAllPoints()
movOptions00.BGtexture:SetPoint("TOPRIGHT", movOptions00, "TOPRIGHT", 0, 0)
movOptions00.BGtexture:SetPoint("BOTTOMLEFT", movOptions00, "BOTTOMLEFT", OptionsW, 0)
movOptions00.BGtexture:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-Achievement-Parchment-Horizontal-Desaturated.blp", "CLAMP", "CLAMP", "NEAREST")
movOptions00.BGtexture:SetDesaturation(0.3)
movOptions00.BGtexture:SetGradient("VERTICAL", C.NoHigh, C.High)
