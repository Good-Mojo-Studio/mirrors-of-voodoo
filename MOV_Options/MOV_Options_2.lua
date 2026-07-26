-- Some variables
local Color = VDW.GetAddonColors("MOV")
local prefixTip = VDW.Prefix("MOV")
local name = ""
local NameExist = false
local Keys = 0
local maxW = 160
local finalW = 0
local counter = 0
-- Finding keys
for k, v in pairs(MOVprofiles) do
	Keys = Keys + 1
end
-- Create panel
VDW.CreateOptionsPanel(movOptions.Panel2, VDW.Background.MOV, Color.Main, Color.High, 0.8, "MOV")
movOptions.Panel2.TopTxt:SetText(VDWtranslate.Global.P_TITLE)
movOptions.Panel2.Box1.Title:SetText(VDWtranslate.Global.P_SUB_CREATE)
movOptions.Panel2.Box2.Title:SetText(VDWtranslate.Global.P_SUB_LOAD)
movOptions.Panel2.Box3.Title:SetText(VDWtranslate.Global.P_SUB_DELETE)
movOptions.Panel2.Box4.Title:SetText(VDWtranslate.Global.IMPORTANT_NOTES)
for i = 1, 4, 1 do
	VDW.CreateOptionsBox(movOptions.Panel2, i, Color.Main, Color.High)
end
-- Box 1, EditBox 1, profile save
VDW.CreateEditBox(movOptions.Panel2, 1, 1, Color.High)
movOptions.Panel2.Box1.EditBox1.WritingLine:HookScript("OnEnter", function(self)
	VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.P_TIP_CREATE, Color.Main, "Left")
end)
-- Pressing enter
movOptions.Panel2.Box1.EditBox1.WritingLine:SetScript("OnEnterPressed", function(self)
	if self:HasText() then
		EditBox_HighlightText(self)
		name = self:GetText()
		NameExist = false
		for k, v in pairs(MOVprofiles) do
			if k == name then NameExist = true end
			if NameExist then
				DEFAULT_CHAT_FRAME:AddMessage(Color.Main:WrapTextInColorCode(VDW.PrefixChat("MOV").." "..VDWtranslate.Global.P_WRN_EXIST))
				UIErrorsFrame:AddExternalWarningMessage(VDW.PrefixError("MOV").." "..VDWtranslate.Global.P_WRN_EXIST)
				return
			end
		end
		MOVprofiles[name] = {settings = MOVsettings}
		C_UI.Reload()
	else
		DEFAULT_CHAT_FRAME:AddMessage(Color.Main:WrapTextInColorCode(VDW.PrefixChat("MOV").." "..VDWtranslate.Global.P_WRN_NEED))
		UIErrorsFrame:AddExternalWarningMessage(VDW.PrefixError("MOV").." "..VDWtranslate.Global.P_WRN_NEED)
	end
end)
-- Box 2-3, PopOut 1, profile (load, delete)
for i = 2, 3, 1 do
	movOptions.Panel2["Box"..i].PopOut1.Text:SetText(VDWtranslate.Global.LEFT_CLICK)
	VDW.CreateOptionsPopOut(movOptions.Panel2, i, 1, Color.Main, Color.High)
	if i == 2 then
		movOptions.Panel2["Box"..i].PopOut1:HookScript("OnEnter", function(self)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.P_TIP_LOAD, Color.Main, "Left")
		end)
		movOptions.Panel2["Box"..i].PopOut1:HookScript("OnClick", function(self, button, down)
			if button == "LeftButton" and down == false then
				if movOptions.Panel2["Box"..i].PopOut1.Choice1 == nil then
					DEFAULT_CHAT_FRAME:AddMessage(Color.Main:WrapTextInColorCode(VDW.PrefixChat("MOV").." "..VDWtranslate.Global.P_WRN_LOAD))
					UIErrorsFrame:AddExternalWarningMessage(VDW.PrefixError("MOV").." "..VDWtranslate.Global.P_WRN_LOAD)
				end
			end
		end)
	else
		movOptions.Panel2["Box"..i].PopOut1:HookScript("OnEnter", function(self)
			VDW.Tooltip_Show(self, prefixTip, VDWtranslate.Global.P_TIP_DELETE, Color.Main, "Left")
		end)
		movOptions.Panel2["Box"..i].PopOut1:HookScript("OnClick", function(self, button, down)
			if button == "LeftButton" and down == false then
				if movOptions.Panel2["Box"..i].PopOut1.Choice1 == nil then
					DEFAULT_CHAT_FRAME:AddMessage(Color.Main:WrapTextInColorCode(VDW.PrefixChat("MOV").." "..VDWtranslate.Global.P_WRN_DELETE))
					UIErrorsFrame:AddExternalWarningMessage(VDW.PrefixError("MOV").." "..VDWtranslate.Global.P_WRN_DELETE)
				end
			end
		end)
	end
	if counter == 0 and Keys > 0 then
		for k, v in pairs(MOVprofiles) do
			counter = counter + 1
			VDW.CreateOptionsPopOutButtons(movOptions.Panel2, i, 1, counter, k, Color.Main)
			movOptions.Panel2["Box"..i].PopOut1["Choice"..counter].Text:SetText(k)
			movOptions.Panel2["Box"..i].PopOut1["Choice"..counter]:HookScript("OnClick", function(self, button, down)
				if button == "LeftButton" and down == false then
					if i == 2 then
						MOVsettings = MOVprofiles[k]["settings"]
						C_UI.Reload()
					else
						MOVprofiles[k] = nil
						C_UI.Reload()
					end
				end
			end)
			local w = movOptions.Panel2["Box"..i].PopOut1["Choice"..counter].Text:GetStringWidth()
			if w > maxW then maxW = w end
		end
		finalW = math.ceil(maxW + 24)
		for c = 1, counter, 1 do
			movOptions.Panel2["Box"..i].PopOut1["Choice"..c]:SetWidth(finalW)
		end
		counter = 0
	end
end
-- Box 4, notes
VDW.CreateImportantNotesProfiles("MOV", movOptions.Panel2, 4, Color.Main, Color.High)
-- Show the panel
movOptions.Panel2:HookScript("OnShow", function(self)
	movOptions.Tab1.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	if movOptions.Panel1:IsShown() then movOptions.Panel1:Hide() end
	movOptions.Tab2.Text:SetTextColor(Color.High:GetRGB())
end)
