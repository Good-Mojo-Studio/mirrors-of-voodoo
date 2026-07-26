-- Some variables
local Color = VDW.GetAddonColors("MOV")
local prefixTip = VDW.Prefix("MOV")
local maxW = 160
local finalW = 0
local counter = 0
local textPosition = {
	{value = "Hide", text = VDWtranslate.Global.HIDE},
	{value = "TopLeft", text = VDWtranslate.Global.TOPLEFT},
	{value = "Left", text = VDWtranslate.Global.LEFT},
	{value = "BottomLeft", text = VDWtranslate.Global.BOTTOMLEFT},
	{value = "Top", text = VDWtranslate.Global.TOP},
	{value = "Center", text = VDWtranslate.Global.CENTER},
	{value = "Bottom", text = VDWtranslate.Global.BOTTOM},
	{value = "TopRight", text = VDWtranslate.Global.TOPRIGHT},
	{value = "Right", text = VDWtranslate.Global.RIGHT},
	{value = "BottomRight", text = VDWtranslate.Global.BOTTOMRIGHT},
}
local textPositionByValue = {}
for _, option in ipairs(textPosition) do
	textPositionByValue[option.value] = option.text
end
-- Create panel
VDW.CreateOptionsPanel(movOptions.Panel1, VDW.Background.MOV, Color.Main, Color.High, 0.8, "MOV")
movOptions.Panel1.TopTxt:SetText("Mirror Bars")
-- Create boxes
movOptions.Panel1.Box1.Title:SetText(VDWtranslate.Global.NAME)
movOptions.Panel1.Box2:SetPoint("TOPLEFT", movOptions.Panel1.Box1, "BOTTOMLEFT", 0, 0)
movOptions.Panel1.Box2.Title:SetText(VDWtranslate.Global.TIME)
for i = 1, 2, 1 do
	VDW.CreateOptionsBox(movOptions.Panel1, i, Color.Main, Color.High)
end
-- Box 1-2, PopOut 1, text position
for i = 1, 2, 1 do
	VDW.CreateOptionsPopOut(movOptions.Panel1, i, 1, Color.Main, Color.High)
	movOptions.Panel1["Box"..i].PopOut1:HookScript("OnEnter", function(self)
		local parent = self:GetParent()
		local word = parent.Title:GetText()
		VDW.Tooltip_Show(self, prefixTip, string.format(VDWtranslate.Global.POSITION_TIP, word), Color.Main, "Left")
	end)
	movOptions.Panel1["Box"..i].PopOut1.Title:SetText(VDWtranslate.Global.POSITION)
	for k, v in pairs(textPosition) do
		counter = counter + 1
		VDW.CreateOptionsPopOutButtons(movOptions.Panel1, i, 1, k, v, Color.Main)
		movOptions.Panel1["Box"..i].PopOut1["Choice"..k]:HookScript("OnClick", function(self, button, down)
			if button == "LeftButton" and down == false then
				if i == 1 then
					MOVsettings.NameText.Position = v.value
				else
					MOVsettings.TimeText.Position = v.value
				end
				movOptions.Panel1["Box"..i].PopOut1.Text:SetText(self.Text:GetText())
				movOptions.Panel1["Box"..i].PopOut1.Choice1:Hide()
			end
		end)
		local w = movOptions.Panel1["Box"..i].PopOut1["Choice"..k].Text:GetStringWidth()
		if w > maxW then maxW = w end
	end
	finalW = math.ceil(maxW + 24)
	for c = 1, counter, 1 do
		movOptions.Panel1["Box"..i].PopOut1["Choice"..c]:SetWidth(finalW)
	end
	counter = 0
	maxW = 160
end
-- Check saved variables
local function CheckSavedVariables()
	movOptions.Panel1.Box1.PopOut1.Text:SetText(textPositionByValue[MOVsettings.NameText.Position] or VDWtranslate.Global.HIDE)
	movOptions.Panel1.Box2.PopOut1.Text:SetText(textPositionByValue[MOVsettings.TimeText.Position] or VDWtranslate.Global.HIDE)
end
-- Show the option panel
movOptions.Panel1:HookScript("OnShow", function(self)
	movOptions.Tab2.Text:SetTextColor(0.4, 0.4, 0.4, 1)
	if movOptions.Panel2:IsShown() then movOptions.Panel2:Hide() end
	movOptions.Tab1.Text:SetTextColor(Color.High:GetRGB())
	CheckSavedVariables()
end)
-- Create background tab
VDW.CreateBackgroundTab(movOptions, VDW.Background.MOV, 0.8, Color.NoHigh, Color.High)
