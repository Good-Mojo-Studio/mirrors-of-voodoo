-- functions for the buttons and popouts --
-- on enter --
function movEnteringMenus(self)
	GameTooltip_ClearStatusBars(GameTooltip)
	GameTooltip:SetOwner(self, "ANCHOR_NONE")
	GameTooltip:ClearAllPoints()
	GameTooltip:SetPoint("RIGHT", self, "LEFT", 0, 0)
end
-- on leave --
function movLeavingMenus()
	GameTooltip:Hide()
end
-- click on Pop Out --
function movClickPopOut(var1, var2)
	var1:SetScript("OnClick", function(self, button, down)
		if button == "LeftButton" and down == false then
			if not var2:IsShown() then
				var2:Show()
			else
				var2:Hide()
			end
		end
	end)
end
