-- some variables --
local G = VDW.Local.Override
local L = VDW.MOV.Local
local C = VDW.GetAddonColors("MOV")
local prefixTip = VDW.Prefix("MOV")
local prefixChat = VDW.PrefixChat("MOV")
local NameExist = false
local maxW = 160
local finalW = 0
local  number = 0
local counterLoading = 0
local counterDeleting = 0
-- Taking care of the option panel --
movOptions2:ClearAllPoints()
movOptions2:SetPoint("TOPLEFT", movOptions00, "TOPLEFT", 0, 0)
-- Background of the option panel --
movOptions2.BGtexture:SetTexture("Interface\\ACHIEVEMENTFRAME\\UI-Achievement-Parchment-Horizontal-Desaturated.blp", "CLAMP", "CLAMP", "NEAREST")
movOptions2.BGtexture:SetVertexColor(C.High:GetRGB())
movOptions2.BGtexture:SetDesaturation(0.3)
-- Title of the option panel --
movOptions2.Title:SetTextColor(C.Main:GetRGB())
movOptions2.Title:SetText(prefixTip.."|nVersion: "..C.High:WrapTextInColorCode(C_AddOns.GetAddOnMetadata("MOV", "Version")))
-- Top text of the option panel --
movOptions2.TopTxt:SetTextColor(C.Main:GetRGB())
movOptions2.TopTxt:SetText(L.P_TITLE)
-- Bottom right text of the option panel --
movOptions2.BottomRightTxt:SetTextColor(C.Main:GetRGB())
movOptions2.BottomRightTxt:SetText(C_AddOns.GetAddOnMetadata("MOV", "X-Website"))
-- taking care of the boxes --
movOptions2Box1.Title:SetText(L.P_SUB_CREATE)
movOptions2Box2.Title:SetText(L.P_SUB_LOAD)
movOptions2Box2:SetPoint("TOPLEFT", movOptions2Box1, "BOTTOMLEFT", 0, 0)
movOptions2Box3.Title:SetText(L.P_SUB_DELETE)
movOptions2Box3:SetPoint("TOPLEFT", movOptions2Box2, "BOTTOMLEFT", 0, 0)
movOptions2Box4.Title:SetText("Important Notes")
movOptions2Box4:SetPoint("TOPLEFT", movOptions2Box3, "BOTTOMLEFT", 0, 0)
-- Coloring the boxes --
for i = 1, 4, 1 do
	_G["movOptions2Box"..i].Title:SetTextColor(C.Main:GetRGB())
	_G["movOptions2Box"..i].BorderTop:SetVertexColor(C.High:GetRGB())
	_G["movOptions2Box"..i].BorderBottom:SetVertexColor(C.High:GetRGB())
	_G["movOptions2Box"..i].BorderLeft:SetVertexColor(C.High:GetRGB())
	_G["movOptions2Box"..i].BorderRight:SetVertexColor(C.High:GetRGB())
end
-- Coloring the pop out buttons --
local function ColoringPopOutButtons(k, var1)
	_G["movOptions2Box"..k.."PopOut"..var1].Text:SetTextColor(C.Main:GetRGB())
	_G["movOptions2Box"..k.."PopOut"..var1].Title:SetTextColor(C.High:GetRGB())
	_G["movOptions2Box"..k.."PopOut"..var1].NormalTexture:SetVertexColor(C.High:GetRGB())
	_G["movOptions2Box"..k.."PopOut"..var1].HighlightTexture:SetVertexColor(C.Main:GetRGB())
	_G["movOptions2Box"..k.."PopOut"..var1].PushedTexture:SetVertexColor(C.High:GetRGB())
end
-- taking care of the edit box --
-- colors --
movOptions2Box1EditBox1["GlowTopLeft"]:SetVertexColor(C.Main:GetRGB())
movOptions2Box1EditBox1["GlowTopRight"]:SetVertexColor(C.Main:GetRGB())
movOptions2Box1EditBox1["GlowBottomLeft"]:SetVertexColor(C.Main:GetRGB())
movOptions2Box1EditBox1["GlowBottomRight"]:SetVertexColor(C.Main:GetRGB())
movOptions2Box1EditBox1["GlowTop"]:SetVertexColor(C.Main:GetRGB())
movOptions2Box1EditBox1["GlowBottom"]:SetVertexColor(C.Main:GetRGB())
movOptions2Box1EditBox1["GlowLeft"]:SetVertexColor(C.Main:GetRGB())
movOptions2Box1EditBox1["GlowRight"]:SetVertexColor(C.Main:GetRGB())
-- width and height --
local fontFile, height, flags = movOptions2Box1EditBox1.WritingLine:GetFont()
movOptions2Box1EditBox1.WritingLine:SetHeight(height)
movOptions2Box1EditBox1:SetWidth(movOptions2Box1:GetWidth()*0.65)
movOptions2Box1EditBox1:SetHeight(movOptions2Box1EditBox1.WritingLine:GetHeight()*1.75)
movOptions2Box1EditBox1.WritingLine:SetWidth(movOptions2Box1EditBox1:GetWidth()*0.95)
-- enter --
movOptions2Box1EditBox1:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.P_TIP_CREATE, C.Main)
end)
-- leave --
movOptions2Box1EditBox1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- pressing enter --
movOptions2Box1EditBox1.WritingLine:SetScript("OnEnterPressed", function(self)
	if self:HasText() then
		EditBox_HighlightText(self)
		local name = self:GetText()
		for k, v in pairs(MOVprofiles) do
			if k == name then
				NameExist = true
			else
				NameExist = false
			end
			if NameExist then
				DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..L.P_WRN_EXIST))
				return
			end
		end
		number = number + 1
		MOVprofiles[name] = {settings = MOVsettings, localization = MOVspecialSettings.LastLocation}
		C_UI.Reload()
	else
		DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..L.P_WRN_NEED))
	end
end)
-- Pop out 1 Buttons loading profiles  --
ColoringPopOutButtons(2, 1)
-- enter --
movOptions2Box2PopOut1:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.P_TIP_LOAD, C.Main)
end)
-- leave --
movOptions2Box2PopOut1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- click --
movOptions2Box2PopOut1:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if movOptions2Box2PopOut1Choice1 ~= nil then
			if not movOptions2Box2PopOut1Choice1:IsShown() then
				movOptions2Box2PopOut1Choice1:Show()
			else
				movOptions2Box2PopOut1Choice1:Hide()
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..L.P_WRN_LOAD))
		end
	end
end)
-- Pop out 1 Buttons deleting profiles  --
ColoringPopOutButtons(3, 1)
-- enter --
movOptions2Box3PopOut1:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, L.P_TIP_DELETE, C.Main)
end)
-- leave --
movOptions2Box3PopOut1:HookScript("OnLeave", function(self) VDW.Tooltip_Hide() end)
-- click --
movOptions2Box3PopOut1:HookScript("OnClick", function(self, button, down)
	if button == "LeftButton" and down == false then
		if movOptions2Box3PopOut1Choice1 ~= nil then
			if not movOptions2Box3PopOut1Choice1:IsShown() then
				movOptions2Box3PopOut1Choice1:Show()
			else
				movOptions2Box3PopOut1Choice1:Hide()
			end
		else
			DEFAULT_CHAT_FRAME:AddMessage(C.Main:WrapTextInColorCode(prefixChat.." "..L.P_WRN_DELETE))
		end
	end
end)
-- finding keys --
local function FindingKeys()
	local Keys = 0
	for k, v in pairs(MOVprofiles) do
		Keys = Keys + 1
	end
	number = Keys
end
-- functions for loading the profiles --
local function LoadingProfiles() -- vdwLoadingProfiles(asv1, asv2, asv3, txt1) 
	if counterLoading == 0 and number > 0 then
		for k, v in pairs(MOVprofiles) do
			counterLoading = counterLoading + 1
			local btn = CreateFrame("Button", "movOptions2Box2PopOut1Choice"..counterLoading, nil, "vdwPopOutButton")
			_G["movOptions2Box2PopOut1Choice"..counterLoading]:ClearAllPoints()
			if counterLoading == 1 then
				_G["movOptions2Box2PopOut1Choice"..counterLoading]:SetParent(movOptions2Box2PopOut1)
				_G["movOptions2Box2PopOut1Choice"..counterLoading]:SetPoint("TOP", movOptions2Box2PopOut1, "BOTTOM", 0, 4)
				_G["movOptions2Box2PopOut1Choice"..counterLoading]:SetScript("OnShow", function(self)
					self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
					PlaySound(855, "Master")
				end)
				_G["movOptions2Box2PopOut1Choice"..counterLoading]:SetScript("OnHide", function(self)
					self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
					PlaySound(855, "Master")
				end)
			else
				_G["movOptions2Box2PopOut1Choice"..counterLoading]:SetParent(movOptions2Box2PopOut1Choice1)
				_G["movOptions2Box2PopOut1Choice"..counterLoading]:SetPoint("TOP", _G["movOptions2Box2PopOut1Choice"..counterLoading-1], "BOTTOM", 0, 0)
				_G["movOptions2Box2PopOut1Choice"..counterLoading]:Show()
			end
				_G["movOptions2Box2PopOut1Choice"..counterLoading].Text:SetText(k)
				_G["movOptions2Box2PopOut1Choice"..counterLoading]:SetWidth(_G["movOptions2Box2PopOut1Choice"..counterLoading].Text:GetWidth())
			_G["movOptions2Box2PopOut1Choice"..counterLoading]:HookScript("OnClick", function(self, button, down)
				if button == "LeftButton" and down == false then
					MOVsettings = MOVprofiles[k]["settings"]
					MOVspecialSettings.LastLocation = MOVprofiles[k]["localization"]
					C_UI.Reload()
				end
			end)
		local w = _G["movOptions2Box2PopOut1Choice"..counterLoading].Text:GetStringWidth()
			if w > maxW then maxW = w end
		end
		finalW = math.ceil(maxW + 24)
		for i = 1, counterLoading do
			_G["movOptions2Box2PopOut1Choice"..i]:SetWidth(finalW)
		end
	end
end
-- functions for deleting the profiles --
local function DeletingProfiles()
	if counterDeleting == 0 and number > 0 then
		for k, v in pairs(MOVprofiles) do
			counterDeleting = counterDeleting + 1
			local btn = CreateFrame("Button", "movOptions2Box3PopOut1Choice"..counterDeleting, nil, "vdwPopOutButton")
			_G["movOptions2Box3PopOut1Choice"..counterDeleting]:ClearAllPoints()
			if counterDeleting == 1 then
				_G["movOptions2Box3PopOut1Choice"..counterDeleting]:SetParent(movOptions2Box3PopOut1)
				_G["movOptions2Box3PopOut1Choice"..counterDeleting]:SetPoint("TOP", movOptions2Box3PopOut1, "BOTTOM", 0, 4)
				_G["movOptions2Box3PopOut1Choice"..counterDeleting]:SetScript("OnShow", function(self)
					self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-hover")
					PlaySound(855, "Master")
				end)
				_G["movOptions2Box3PopOut1Choice"..counterDeleting]:SetScript("OnHide", function(self)
					self:GetParent():SetNormalAtlas("charactercreate-customize-dropdownbox-open")
					PlaySound(855, "Master")
				end)
			else
				_G["movOptions2Box3PopOut1Choice"..counterDeleting]:SetParent(movOptions2Box3PopOut1Choice1)
				_G["movOptions2Box3PopOut1Choice"..counterDeleting]:SetPoint("TOP", _G["movOptions2Box3PopOut1Choice"..counterDeleting-1], "BOTTOM", 0, 0)
				_G["movOptions2Box3PopOut1Choice"..counterDeleting]:Show()
			end
				_G["movOptions2Box3PopOut1Choice"..counterDeleting].Text:SetText(k)
				_G["movOptions2Box3PopOut1Choice"..counterDeleting]:SetWidth(_G["movOptions2Box3PopOut1Choice"..counterDeleting].Text:GetWidth())
			_G["movOptions2Box3PopOut1Choice"..counterDeleting]:HookScript("OnClick", function(self, button, down)
				if button == "LeftButton" and down == false then
					MOVprofiles[k] = nil
					C_UI.Reload()
				end
			end)
		local w = _G["movOptions2Box3PopOut1Choice"..counterDeleting].Text:GetStringWidth()
			if w > maxW then maxW = w end
		end
		finalW = math.ceil(maxW + 24)
		for i = 1, counterDeleting do
			_G["movOptions2Box3PopOut1Choice"..i]:SetWidth(finalW)
		end
	end
end
movOptions2Box2PopOut1.Text:SetText(G.BUTTON_L_CLICK)
movOptions2Box3PopOut1.Text:SetText(G.BUTTON_L_CLICK)
FindingKeys()
LoadingProfiles()
DeletingProfiles()
-- Show the option panel --
movOptions2:HookScript("OnShow", function(self)
	movOptions00Tab1.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	if movOptions1:IsShown() then movOptions1:Hide() end
	movOptions00Tab2.Text:SetTextColor(C.High:GetRGB())
end)
