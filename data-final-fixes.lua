local stackMultiplier = settings.startup["sm-stack-size-multiplier"].value
local newStackSize = settings.startup["sm-items-stacks"].value
local newDefReqStackSize = settings.startup["sm-items-def-req"].value
local GTypes = { "item", "ammo", "capsule", "module", "tool", "repair-tool", "item-with-entity-data", "rail-planner", "rail-signal", "rail-chain-signal", "gun"}
local possibleFlags = { "draw-logistic-overlay", "hidden", "always-show", "hide-from-bonus-gui", "hide-from-fuel-tooltip", "not-stackable", "can-extend-inventory", "primary-place-result", "mod-openable", "only-in-cursor", "spawnable" }

local function parseStringToTable(inputString)
	local resultTable = {}
	for item in inputString:gmatch("[a-z%-]+") do
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

local function clamp(value, min, max)
    if value < min then
        return min
    elseif value > max then
        return max
    else
        return value
    end
end

local itemTypes = parseStringToTable(settings.startup["sm-item-types"].value)
local itemNames = parseStringToTable(settings.startup["sm-item-names"].value)

local function getItemsForUpdate(itemNames, GTypes)
    local itemsToUpdate = {}
    for _, itemType in ipairs(GTypes) do
        local typeData = data.raw[itemType]
        if typeData then
            for _, itemName in ipairs(itemNames) do
                local item = typeData[itemName]
                if item then
                    itemsToUpdate[#itemsToUpdate + 1] = item
                end
            end
        end
    end
    return itemsToUpdate
end

local function processItemFlags(item)
    if item.hidden then 
		return false
	elseif item == nil then
		return false
	elseif item.flags then
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
    if item == nil then end
	if item.stack_size then
        if useMultiplier then
            item.stack_size = clamp((item.stack_size * stackMultiplier), 1, 4000000)
            item.default_request_amount = clamp((newDefReqStackSize * stackMultiplier), 1, 4000000)
        elseif useNewStack then
            item.stack_size = newStackSize
            item.default_request_amount = newDefReqStackSize
        end
    end
end

local function updateItemWeight(item)
    if item.weight then
        item.weight = item.weight / settings.startup["sm-weight"].value
    else
        log("Item: '" .. (item.name or "unknown") .. "' has no weight?")
    end
end

if settings.startup["sm-enable-type"].value then
    for _, itemType in pairs(itemTypes) do
        if data.raw[itemType] then
            for _, item in pairs(data.raw[itemType]) do
                local shouldChange = processItemFlags(item)
                if shouldChange then
                    if settings.startup["sm-enable-stack-size-multiplier"].value and not settings.startup["sm-enable-rewrite"].value then
                        updateItemStackSize(item, true, false)
                    elseif not settings.startup["sm-enable-stack-size-multiplier"].value and not settings.startup["sm-enable-rewrite"].value then
                        updateItemStackSize(item, false, true)
                    elseif settings.startup["sm-enable-stack-size-multiplier"].value and settings.startup["sm-enable-rewrite"].value then
                        updateItemStackSize(item, true, false)
                    end
                end
            end
        else
            log("Warning type: '" .. itemType .. "' does not exist?")
        end
    end
end

if settings.startup["sm-enable-name"].value then
	local itemsToUpdate = getItemsForUpdate(itemNames, GTypes)
	for _, item in ipairs(itemsToUpdate) do
		local shouldChange = processItemFlags(item)
		if shouldChange then
			if settings.startup["sm-enable-stack-size-multiplier"].value and not settings.startup["sm-enable-rewrite"].value then
				updateItemStackSize(item, true, false)
			elseif not settings.startup["sm-enable-stack-size-multiplier"].value and not settings.startup["sm-enable-rewrite"].value then
				updateItemStackSize(item, false, true)
			elseif settings.startup["sm-enable-stack-size-multiplier"].value and settings.startup["sm-enable-rewrite"].value then
				updateItemStackSize(item, false, true)
			end
		end
	end
end
-- SA
if mods["space-age"] then
	local weightTypes = parseStringToTable(settings.startup["sm-weight-item-types"].value)
	local weightNames = parseStringToTable(settings.startup["sm-weight-item-names"].value)
	if settings.startup["sm-enable-weight"].value then
		if settings.startup["sm-if-weight"].value then
			for _, weightTypes in pairs(weightTypes) do
				if data.raw[weightTypes] then
					for _, item in pairs(data.raw[weightTypes]) do
						updateItemWeight(item)
					end
				else
					log("Warning type: '" .. weightTypes .. "' does not exist?")
				end
			end
		elseif not settings.startup["sm-if-weight"].value then
			for _, weightNames in pairs(weightNames) do
				local item = data.raw["item"] and data.raw["item"][weightNames]
				if item then
					updateItemWeight(item)
				else
					log("Warning name: '" .. weightNames .. "' does not exist?")
				end
			end
		end
	end
end
-- SE
if mods["space-exploration"] then
	data.raw.item["rocket-fuel"].stack_size = 10
end