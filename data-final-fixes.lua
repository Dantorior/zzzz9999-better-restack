local stackMultiplier = settings.startup["sm-stack-size-multiplier"].value
local newStackSize = settings.startup["sm-items-stacks"].value
local newDefReqStackSize = settings.startup["sm-items-def-req"].value

local possibleFlags = { "draw-logistic-overlay", "hidden", "always-show", "hide-from-bonus-gui", "hide-from-fuel-tooltip", "not-stackable", "can-extend-inventory", "primary-place-result", "mod-openable", "only-in-cursor", "spawnable" }

local function parseStringToTable(inputString)
	local resultTable = {}
	for item in inputString:gmatch("[^%s,]+") do
		table.insert(resultTable, item)
	end
	return resultTable
end

local function tableContains(tbl, element)
	for _, value in ipairs(tbl) do
		if value == element then
			return true
		end
	end
	return false
end

local itemTypes = parseStringToTable(settings.startup["sm-item-types"].value)
local itemNames = parseStringToTable(settings.startup["sm-item-names"].value)

local function processItemFlags(item)
    if item.flags then
        for _, flag in ipairs(item.flags) do
            if tableContains(possibleFlags, flag) then
                if flag == "not-stackable" then
                    item.stack_size = 1
                    return false
                end
            end
        end
    end
    return true
end

local function updateItemStackSize(item, useMultiplier, useNewStack)
    if item.stack_size then
        if useMultiplier then
            item.stack_size = item.stack_size * stackMultiplier
            item.default_request_amount = newDefReqStackSize * stackMultiplier
        elseif useNewStack then
            item.stack_size = newStackSize
            item.default_request_amount = newDefReqStackSize
        end
    end
end

local function updateItemWeight(item)
	if item.weight then
		item.weight = item.weight / settings.startup["sm-weight"].value
    end
end

if settings.startup["sm-enable-type"].value then
    for _, itemType in pairs(itemTypes) do
        if data.raw[itemType] then
            for _, item in pairs(data.raw[itemType]) do
                local shouldChange = processItemFlags(item)
                if shouldChange then
                    updateItemStackSize(item, true, false)
                end
            end
        else
            log("Warning: item type '" .. itemType .. "' does not exist.")
        end
    end
end

if settings.startup["sm-enable-name"].value then
	for _, itemName in pairs(itemNames) do
		local item = data.raw["item"] and data.raw["item"][itemName]
		if item then
			local shouldChange = processItemFlags(item)
			if shouldChange then
				if settings.startup["sm-enable-stack-size-multiplier"].value and not settings.startup["sm-enable-rewrite"].value then
					updateItemStackSize(item, true, false)
				elseif not settings.startup["sm-enable-stack-size-multiplier"].value and not settings.startup["sm-enable-rewrite"].value  then
					updateItemStackSize(item, false, true)
				elseif settings.startup["sm-enable-stack-size-multiplier"].value and settings.startup["sm-enable-rewrite"].value then
					updateItemStackSize(item, false, true)
				end
			end
		else
			log("Warning: item name '" .. itemName .. "' does not exist.")
		end
	end
end
if mods["space-age"] then
	local weightTypes = parseStringToTable(settings.startup["sm-weight-item-types"].value)
	local weightNames = parseStringToTable(settings.startup["sm-weight-item-names"].value)
	if settings.startup["sm-enable-weight"].value then
		if settings.startup["sm-if-weight"].value then
			for _, weightTypes in pairs(weightTypes) do
				local weightOfType = data.raw[weightTypes]
				if weightOfType then
					updateItemWeight(weightOfType)
				else
					log("Warning: item type '" .. weightTypes .. "' does not exist.")
				end
			end
		elseif not settings.startup["sm-if-weight"].value then
			for _, weightNames in pairs(weightNames) do
				local weightOfName = data.raw["item"] and data.raw["item"][weightNames]
				if weightOfName then
					updateItemWeight(weightOfName)
				else
					log("Warning: item name '" .. weightNames .. "' does not exist.")
				end
			end
		end
	end
end
-- SE
if mods["space-exploration"] then
	data.raw.item["rocket-fuel"].stack_size = 10
end