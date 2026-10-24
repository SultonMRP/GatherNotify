GatherNotify = {}
GatherNotify.Frame = CreateFrame("Frame", "GatherNotifyFrame", UIParent)

-- Table format: {level, prettyName, objectName}
-- prettyName nil = tooltip only (do not announce on skill-up)
-- objectName nil = same as prettyName
-- Skill values are 3.3.5a required skill from wotlkdb.

GatherNotify.levels = {
	mining = {
		{1, "Copper", "Copper Vein"},
		{65, "Tin", "Tin Vein"},
		{65, nil, "Incendicite Mineral Vein"},
		{75, "Silver", "Silver Vein"},
		{75, nil, "Ooze Covered Silver Vein"},
		{75, nil, "Lesser Bloodstone Deposit"},
		{125, "Iron", "Iron Deposit"},
		{150, nil, "Indurium Mineral Vein"},
		{155, "Gold", "Gold Vein"},
		{155, nil, "Ooze Covered Gold Vein"},
		{175, "Mithril", "Mithril Deposit"},
		{175, nil, "Ooze Covered Mithril Deposit"},
		{205, "Truesilver", "Truesilver Deposit"},
		{205, nil, "Ooze Covered Truesilver Deposit"},
		{230, "Dark Iron", "Dark Iron Deposit"},
		{230, "Small Thorium", "Small Thorium Vein"},
		{230, nil, "Ooze Covered Thorium Vein"},
		{255, "Rich Thorium", "Rich Thorium Vein"},
		{255, nil, "Ooze Covered Rich Thorium Vein"},
		{255, nil, "Hakkari Thorium Vein"},
		{275, "Fel Iron", "Fel Iron Deposit"},
		{275, nil, "Nethercite Deposit"},
		{305, nil, "Small Obsidian Chunk"},
		{305, nil, "Large Obsidian Chunk"},
		{325, "Adamantite", "Adamantite Deposit"},
		{350, "Rich Adamantite", "Rich Adamantite Deposit"},
		{350, "Cobalt", "Cobalt Deposit"},
		{350, nil, "Cobalt Vein"},
		{375, "Khorium", "Khorium Vein"},
		{375, "Rich Cobalt", "Rich Cobalt Deposit"},
		{375, nil, "Ancient Gem Vein"},
		{400, "Saronite", "Saronite Deposit"},
		{400, nil, "Saronite Vein"},
		{425, "Rich Saronite", "Rich Saronite Deposit"},
		{450, "Titanium", "Titanium Vein"},
		{450, nil, "Titanium Deposit"},
		{450, nil, "Pure Saronite Deposit"},
	},

	herbalism = {
		{1, "Peacebloom"},
		{1, "Silverleaf"},
		{1, "Bloodthistle"},
		{15, "Earthroot"},
		{50, "Mageroyal"},
		{70, "Briarthorn"},
		{85, "Stranglekelp"},
		{100, "Bruiseweed"},
		{115, "Wild Steelbloom"},
		{120, "Grave Moss"},
		{125, "Kingsblood"},
		{150, "Liferoot"},
		{160, "Fadeleaf"},
		{170, "Goldthorn"},
		{185, "Khadgar's Whisker"},
		{195, "Wintersbite"},
		{205, "Firebloom"},
		{210, "Purple Lotus"},
		{220, "Arthas' Tears"},
		{230, "Sungrass"},
		{235, "Blindweed"},
		{245, "Ghost Mushroom"},
		{250, "Gromsblood"},
		{260, "Golden Sansam"},
		{270, "Dreamfoil"},
		{280, "Mountain Silversage"},
		{285, "Plaguebloom"},
		{290, "Icecap"},
		{300, "Black Lotus"},
		{300, "Felweed"},
		{315, "Dreaming Glory"},
		{325, "Ragveil"},
		{325, "Terocone"},
		{335, "Flame Cap"},
		{340, "Ancient Lichen"},
		{350, "Netherbloom"},
		{350, "Goldclover"},
		{350, nil, "Netherdust Bush"},
		{360, "Firethorn"},
		{365, "Nightmare Vine"},
		{375, "Mana Thistle"},
		{375, "Tiger Lily"},
		{385, "Talandra's Rose"},
		{400, "Frozen Herb"},
		{400, "Adder's Tongue"},
		{425, "Lichbloom"},
		{435, "Icethorn"},
		{450, "Frost Lotus"},
	},

	skinning = {
		{1, nil, "1"}, {1, nil, "2"}, {1, nil, "3"}, {1, nil, "4"}, {1, nil, "5"},
		{1, nil, "6"}, {1, nil, "7"}, {1, nil, "8"}, {1, nil, "9"}, {1, nil, "10"},
		{10, "11"}, {20, "12"}, {30, "13"}, {40, "14"}, {50, "15"},
		{60, "16"}, {70, "17"}, {80, "18"}, {90, "19"}, {100, "20"},
		{105, "21"}, {110, "22"}, {115, "23"}, {120, "24"}, {125, "25"},
		{130, "26"}, {135, "27"}, {140, "28"}, {145, "29"}, {150, "30"},
		{155, "31"}, {160, "32"}, {165, "33"}, {170, "34"}, {175, "35"},
		{180, "36"}, {185, "37"}, {190, "38"}, {195, "39"}, {200, "40"},
		{205, "41"}, {210, "42"}, {215, "43"}, {220, "44"}, {225, "45"},
		{230, "46"}, {235, "47"}, {240, "48"}, {245, "49"}, {250, "50"},
		{255, "51"}, {260, "52"}, {265, "53"}, {270, "54"}, {275, "55"},
		{280, "56"}, {285, "57"}, {290, "58"}, {295, "59"}, {300, "60"},
		{305, "61"}, {310, "62"}, {315, "63"}, {320, "64"}, {325, "65"},
		{330, "66"}, {335, "67"}, {340, "68"}, {345, "69"}, {350, "70"},
		{355, "71"}, {360, "72"}, {365, "73"}, {375, "74"}, {385, "75"},
		{395, "76"}, {405, "77"}, {415, "78"}, {425, "79"}, {435, "80"},
	}
}

local function GN_Trim(text)
	return (tostring(text or ""):gsub("^%s+", ""):gsub("%s+$", ""))
end

local function GN_Strip(text)
	if type(text) ~= "string" then
		return ""
	end
	return GN_Trim(text:gsub("|c%x%x%x%x%x%x%x%x", ""):gsub("|r", ""):gsub("|T.-|t", ""))
end

local function GN_After(delay, func)
	local frame = CreateFrame("Frame", nil, UIParent)
	local elapsed = 0
	frame:SetScript("OnUpdate", function(self, e)
		elapsed = elapsed + (e or 0)
		if elapsed >= delay then
			self:SetScript("OnUpdate", nil)
			func()
		end
	end)
end

local function GN_TooltipFontString(tooltip, i)
	local prefix = (tooltip and tooltip:GetName()) or "GameTooltip"
	local fontstring = _G[prefix.."TextLeft"..i]
	return fontstring, fontstring and fontstring:GetText()
end

function GatherNotify.OnEvent(self, event, ...)
	if event == "PLAYER_LOGIN" then
		GatherNotify.Init()
	elseif event == "CHAT_MSG_SKILL" then
		local msg = ...
		GN_After(0.1, function()
			GatherNotify.OnSkillUpMessage(msg)
		end)
	end
end

function GatherNotify.Init()
	if GatherNotify.initialized then
		return
	end
	GatherNotify.initialized = true

	-- Hook after TipTac (it hooks on VARIABLES_LOADED so it can rewrite unit tips last).
	GameTooltip:HookScript("OnShow", function(self)
		GatherNotify.ProcessTooltip(self, true)
	end)
	GameTooltip:HookScript("OnTooltipSetUnit", function(self)
		GatherNotify.ProcessTooltip(self, true)
	end)
	GameTooltip:HookScript("OnTooltipCleared", function()
		GatherNotify.applied = nil
	end)
	GameTooltip:HookScript("OnUpdate", function(self)
		GatherNotify.ProcessTooltip(self, false)
	end)
	hooksecurefunc(GameTooltip, "Show", function(self)
		if GatherNotify.updating then
			return
		end
		GatherNotify.ProcessTooltip(self, true)
	end)

	GatherNotify.origErrorFunc = UIErrorsFrame:GetScript("OnEvent")
	UIErrorsFrame:SetScript("OnEvent", GatherNotify.OnUIError)
	if GatherNotifyTip then
		GatherNotifyTip:Hide()
	end
end

function GatherNotify.OnCommand(cmd)
	cmd = GN_Trim(cmd):lower()

	if #cmd > 0 then
		for i = 0, 8 do
			if cmd == string.sub("skinning", 1, -i-1) then
				GatherNotify.PrintHighestNode("skinning")
				return
			elseif cmd == string.sub("mining", 1, -i-1) then
				GatherNotify.PrintHighestNode("mining")
				return
			elseif cmd == string.sub("herbalism", 1, -i-1) then
				GatherNotify.PrintHighestNode("herbalism")
				return
			elseif cmd == string.sub("version", 1, -i-1) then
				local version = GetAddOnMetadata("GatherNotify", "Version") or "?"
				local date = GetAddOnMetadata("GatherNotify", "X-Date") or ""
				GatherNotify.Msg(string.format("GatherNotify version: |cff1aff1a%s|cffFFC300 (%s)", version, date), true)
				return
			end
		end
	end

	GatherNotify.Msg("/gn skinning - Print highest level creature you can skin", true)
	GatherNotify.Msg("/gn mining - Print highest node you can mine", true)
	GatherNotify.Msg("/gn herbalism - Print highest herb you can pick", true)
	GatherNotify.Msg("/gn version - Prints addon version", true)
end

function GatherNotify.OnUIError(self, event, ...)
	if event == "UI_ERROR_MESSAGE" then
		-- 3.3.5a: (message). Later clients: (errorType, message).
		local err = ...
		if type(err) == "number" then
			err = select(2, ...)
		end
		if type(err) == "string" then
			local skill = string.match(err, "Requires ([%a']+) ")
			local rlevel = tonumber(string.match(err, "Requires .+ (%d+)"))
			if skill and rlevel then
				local level, temp = GatherNotify.GetProfessionLevel(skill)
				if level then
					GatherNotify.AddError(skill, rlevel, level, temp or 0)
					return
				end
			end
		end
	end
	if GatherNotify.origErrorFunc then
		return GatherNotify.origErrorFunc(self, event, ...)
	end
end

function GatherNotify.OnSkillUpMessage(msg)
	if type(msg) ~= "string" then
		return
	end

	local skill = string.match(msg, "Your skill in (%a+) has increased to")
	if skill ~= "Mining" and skill ~= "Herbalism" and skill ~= "Skinning" then
		return
	end

	local level, temp = GatherNotify.GetProfessionLevel(skill)
	if not level then
		return
	end
	temp = temp or 0

	local new = GatherNotify.GetAllGatherable(skill, level)
	if new then
		local tempmsg = ""
		if temp > 0 then
			tempmsg = " (without current |cff1aff1a+"..temp.."|cffFFC300 bonus)"
		end
		if skill == "Skinning" then GatherNotify.Msg("Now able to skin level "..new.." creatures"..tempmsg, false)
		elseif skill == "Mining" then GatherNotify.Msg("Now able to mine "..new..tempmsg, false)
		elseif skill == "Herbalism" then GatherNotify.Msg("Now able to pick "..new..tempmsg, false)
		end
	end

	local newtemp = GatherNotify.GetAllGatherable(skill, level + temp)
	if newtemp and newtemp ~= new then
		local tempmsg = ""
		if temp > 0 then
			tempmsg = " (with current |cff1aff1a+"..temp.."|cffFFC300 bonus)"
		end
		if skill == "Skinning" then GatherNotify.Msg("Now able to skin level "..newtemp.." creatures"..tempmsg, false)
		elseif skill == "Mining" then GatherNotify.Msg("Now able to mine "..newtemp..tempmsg, false)
		elseif skill == "Herbalism" then GatherNotify.Msg("Now able to pick "..newtemp..tempmsg, false)
		end
	end
end

function GatherNotify.Msg(msg, printname, color)
	color = color or "FFC300"
	if printname then
		DEFAULT_CHAT_FRAME:AddMessage("|cffd2b48c[GatherNotify]|r |cff"..color..msg)
	else
		DEFAULT_CHAT_FRAME:AddMessage("|cff"..color..msg)
	end
end

function GatherNotify.AddError(skill, rlevel, current, temp)
	if temp == 0 then
		UIErrorsFrame:AddMessage(string.format("Requires %s %s (currently %s)", skill, rlevel, current), 1.0, 0.1, 0.1)
	else
		UIErrorsFrame:AddMessage(string.format("Requires %s %s (currently %s|cff1aff1a+%s|r)", skill, rlevel, current, temp), 1.0, 0.1, 0.1)
	end
end

function GatherNotify.GetHighestNode(skill, level)
	skill = skill:lower()
	if not GatherNotify.levels[skill] then
		return
	end

	local highest = 0
	for _, v in ipairs(GatherNotify.levels[skill]) do
		if v[1] <= level and v[2] and v[1] > highest then
			highest = v[1]
		end
	end

	return GatherNotify.GetAllGatherable(skill, highest)
end

function GatherNotify.PrintHighestNode(skill)
	local level, temp = GatherNotify.GetProfessionLevel(skill)
	if not level then
		GatherNotify.Msg("You don't have "..skill, true)
		return
	end
	temp = temp or 0

	local withoutBonus = GatherNotify.GetHighestNode(skill, level)
	local withBonus = GatherNotify.GetHighestNode(skill, level + temp)
	if not withoutBonus then
		GatherNotify.Msg(skill.." "..level..": nothing new yet", true)
		return
	end

	local tempmsg = ""
	if temp > 0 and withBonus ~= withoutBonus then
		tempmsg = " (without current |cff1aff1a+"..temp.."|cffFFC300 bonus)"
	end

	if skill == "skinning" then GatherNotify.Msg("Skinning "..level..": level "..withoutBonus.." creatures"..tempmsg, true) end
	if skill == "mining" then GatherNotify.Msg("Mining "..level..": "..withoutBonus..tempmsg, true) end
	if skill == "herbalism" then GatherNotify.Msg("Herbalism "..level..": "..withoutBonus..tempmsg, true) end

	if withBonus and withBonus ~= withoutBonus then
		tempmsg = ""
		if temp > 0 then
			tempmsg = " (with current |cff1aff1a+"..temp.."|cffFFC300 bonus)"
		end
		if skill == "skinning" then GatherNotify.Msg("Skinning |cff1aff1a"..(level+temp).."|cffFFC300: level "..withBonus.." creatures"..tempmsg, true) end
		if skill == "mining" then GatherNotify.Msg("Mining |cff1aff1a"..(level+temp).."|cffFFC300: "..withBonus..tempmsg, true) end
		if skill == "herbalism" then GatherNotify.Msg("Herbalism |cff1aff1a"..(level+temp).."|cffFFC300: "..withBonus..tempmsg, true) end
	end
end

function GatherNotify.GetAllGatherable(skill, level)
	skill = skill:lower()
	if not GatherNotify.levels[skill] then
		return
	end

	local ret = {}
	for _, v in ipairs(GatherNotify.levels[skill]) do
		if v[1] == level and v[2] then
			table.insert(ret, v[2])
		end
	end

	if #ret == 0 then
		return nil
	end
	return table.concat(ret, ", ")
end

function GatherNotify.GetRequiredLevel(skill, name)
	name = tostring(name)
	skill = skill:lower()
	if not GatherNotify.levels[skill] then
		return
	end

	local req
	local nameLower = name:lower()
	for _, v in ipairs(GatherNotify.levels[skill]) do
		local objectName = v[3] or v[2]
		if objectName and objectName:lower() == nameLower then
			req = v[1]
		end
	end
	return req
end

function GatherNotify.GetProfessionLevel(name)
	if not name or not GetNumSkillLines then
		return
	end
	local numSkills = GetNumSkillLines()
	for i = 1, numSkills do
		-- 3.3.5a: name, isHeader, isExpanded, rank, numTempPoints, skillModifier, skillMaxRank, ...
		local skillname, isHeader, _, skillrank, _, skillmodifier = GetSkillLineInfo(i)
		if skillname and not isHeader and skillname:lower() == name:lower() then
			return skillrank, skillmodifier or 0
		end
	end
end

local function GN_IsSkillLine(text, skill)
	text = GN_Strip(text)
	if text == "" then
		return false
	end
	return text == skill or text == "Requires "..skill or string.find(text, "^Requires "..skill)
end

function GatherNotify.GetSkinningRequirement(level)
	level = tonumber(level)
	if not level or level < 1 then
		return
	end
	local req = GatherNotify.GetRequiredLevel("Skinning", level)
	if req then
		return req
	end
	if level <= 10 then
		return 1
	elseif level <= 20 then
		return (level - 10) * 10
	elseif level <= 73 then
		return level * 5
	elseif level == 74 then
		return 375
	elseif level == 75 then
		return 385
	elseif level == 76 then
		return 395
	elseif level == 77 then
		return 405
	elseif level == 78 then
		return 415
	elseif level == 79 then
		return 425
	end
	return 435
end

function GatherNotify.GetTooltipUnit(tooltip)
	if tooltip.GetUnit then
		local _, unit = tooltip:GetUnit()
		if unit and UnitExists(unit) then
			return unit
		end
	end
	if UnitExists("mouseover") then
		return "mouseover"
	end
end

function GatherNotify.GetUnitLevelFromTooltip(tooltip, unit)
	if unit and UnitExists(unit) then
		local level = UnitLevel(unit)
		if level and level > 0 then
			return level
		end
	end
	for i = 1, tooltip:NumLines() or 0 do
		local text = GN_Strip(select(2, GN_TooltipFontString(tooltip, i)))
		local n = text:match("Level%s+(%d+)") or text:match("^%+?(%d+)%s")
		n = tonumber(n)
		if n and n > 0 and n <= 80 then
			return n
		end
	end
end

function GatherNotify.FormatSkillLine(label, req, skillname)
	local text = label.." "..req
	local skill, tempboost = GatherNotify.GetProfessionLevel(skillname)
	tempboost = tempboost or 0
	if skill and req > (skill + tempboost) then
		if tempboost > 0 then
			text = text..string.format(" (currently %s|cff1aff1a+%s|r)", skill, tempboost)
		else
			text = text.." (currently "..skill..")"
		end
	end
	return text
end

function GatherNotify.HasSkinningLine(tooltip)
	local fallback
	for i = 1, tooltip:NumLines() or 0 do
		local text = GN_Strip(select(2, GN_TooltipFontString(tooltip, i)))
		if text == "Skinnable" or text:match("^Skinnable") or text:match("^Requires Skinning") then
			return true, i
		elseif text:find("Skinnable") then
			fallback = i
		end
	end
	if fallback then
		return true, fallback
	end
end

function GatherNotify.IsSkinType(unit)
	if not unit or not UnitExists(unit) or UnitIsPlayer(unit) or UnitPlayerControlled(unit) then
		return false
	end
	local ctype = UnitCreatureType(unit)
	return ctype == "Beast" or ctype == "Dragonkin"
end

function GatherNotify.IsProbablySkinnable(unit)
	return GatherNotify.IsSkinType(unit) and UnitIsDead(unit)
end

function GatherNotify.IsLiveSkinEstimate(unit)
	if not GatherNotify.IsSkinType(unit) or UnitIsDead(unit) then
		return false
	end
	if not UnitCanAttack("player", unit) then
		return false
	end
	local classif = UnitClassification(unit)
	if classif == "minus" or classif == "trivial" then
		return false
	end
	return true
end

function GatherNotify.TooltipHasSkinInfo(tooltip)
	for i = 1, tooltip:NumLines() or 0 do
		local text = GN_Strip(select(2, GN_TooltipFontString(tooltip, i)))
		if text:find("Est. Skinning") or text:find("currently") or text:match("Skinnable%s+%d+") or text:match("Requires Skinning%s+%d+") then
			return true
		end
	end
end

function GatherNotify.FindGatherInfo(tooltip)
	if not tooltip then
		return
	end
	if tooltip.GetItem then
		local itemName = tooltip:GetItem()
		if itemName then
			return
		end
	end

	local numLines = tooltip:NumLines() or 0
	if numLines < 1 then
		return
	end

	local _, line1 = GN_TooltipFontString(tooltip, 1)
	line1 = GN_Strip(line1)
	if line1 == "" then
		return
	end

	for i = 1, numLines do
		local fontstring, raw = GN_TooltipFontString(tooltip, i)
		local text = GN_Strip(raw)
		if fontstring and text ~= "" then
			if GN_IsSkillLine(text, "Mining") then
				local req = GatherNotify.GetRequiredLevel("Mining", line1)
				if req then
					return "Mining", line1, i, fontstring, raw, req
				end
			elseif GN_IsSkillLine(text, "Herbalism") then
				local req = GatherNotify.GetRequiredLevel("Herbalism", line1)
				if req then
					return "Herbalism", line1, i, fontstring, raw, req
				end
			end
		end
	end
end

function GatherNotify.AddSkinningLine(tooltip, text, r, g, b)
	tooltip:AddLine(text, r, g, b)
	GatherNotify.updating = true
	tooltip:Show()
	GatherNotify.updating = false
end

function GatherNotify.ProcessSkinningTooltip(tooltip)
	local unit = GatherNotify.GetTooltipUnit(tooltip)
	local hasSkinning, lineIndex = GatherNotify.HasSkinningLine(tooltip)
	local deadGuess = GatherNotify.IsProbablySkinnable(unit)
	local liveGuess = GatherNotify.IsLiveSkinEstimate(unit)
	if not hasSkinning and not deadGuess and not liveGuess then
		return
	end

	local level = GatherNotify.GetUnitLevelFromTooltip(tooltip, unit)
	local req = GatherNotify.GetSkinningRequirement(level)
	if not req then
		return
	end

	if GatherNotify.TooltipHasSkinInfo(tooltip) then
		return
	end

	local skill, tempboost = GatherNotify.GetProfessionLevel("Skinning")
	tempboost = tempboost or 0
	local canSkin = skill and req <= (skill + tempboost)
	local r, g, b = 1, 0.82, 0
	if skill then
		if canSkin then
			r, g, b = 0.2, 1, 0.2
		else
			r, g, b = 1, 0.1, 0.1
		end
	end

	if hasSkinning or deadGuess then
		local newstr = GatherNotify.FormatSkillLine("Skinnable", req, "Skinning")
		local fontstring = lineIndex and select(1, GN_TooltipFontString(tooltip, lineIndex))
		local lineText = fontstring and GN_Strip(fontstring:GetText()) or ""
		if fontstring and (lineText == "Skinnable" or lineText:match("^Skinnable")) then
			fontstring:SetText(newstr)
			GatherNotify.updating = true
			tooltip:Show()
			GatherNotify.updating = false
		else
			GatherNotify.AddSkinningLine(tooltip, newstr, r, g, b)
		end
		return
	end

	GatherNotify.AddSkinningLine(tooltip, GatherNotify.FormatSkillLine("Est. Skinning", req, "Skinning"), r, g, b)
end

function GatherNotify.ProcessTooltip(tooltip)
	if not tooltip or not tooltip:IsShown() then
		return
	end

	GatherNotify.ProcessSkinningTooltip(tooltip)

	local skillname, objname, linenum, fontstring, raw, req = GatherNotify.FindGatherInfo(tooltip)
	if not skillname or not fontstring then
		return
	end

	local label = GN_Strip(raw)
	if label == "" then
		label = skillname
	elseif string.find(label, "%d") then
		label = label:gsub("%s+%d+.*$", "")
	end

	local newstr = GatherNotify.FormatSkillLine(label, req, skillname)
	if fontstring:GetText() ~= newstr then
		fontstring:SetText(newstr)
		GatherNotify.updating = true
		tooltip:Show()
		GatherNotify.updating = false
	end
end

SLASH_GN1, SLASH_GN2, SLASH_GN3 = "/gn", "/gathernotify", "/gnotify"
SlashCmdList["GN"] = GatherNotify.OnCommand

GatherNotify.Frame:SetScript("OnEvent", GatherNotify.OnEvent)
GatherNotify.Frame:RegisterEvent("CHAT_MSG_SKILL")
GatherNotify.Frame:RegisterEvent("PLAYER_LOGIN")

