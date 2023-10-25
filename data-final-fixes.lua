-- New stack size
local newStackSize = settings.startup["all-items-stacks"].value
-- New default request size
local newDefReqStackSize = settings.startup["all-items-stacks-def-req"].value
-- Item types to update
local typesString = settings.startup["all-item-types"].value
-- Set of possible flags
local possibleFlags = { "draw-logistic-overlay", "hidden", "always-show", "hide-from-bonus-gui", "hide-from-fuel-tooltip", "not-stackable", "can-extend-inventory", "primary-place-result", "mod-openable", "only-in-cursor", "spawnable" }
-- Set for item types
local itemTypes = {}
-- Extracting individual types from the string
for typeStr in typesString:gmatch("[^%s,]+") do
    table.insert(itemTypes, typeStr)
end
-- Check set return true/false
function table.contains(table, element)
	for _, value in ipairs(table) do
		if value == element then
			return true
		end
	end
	return false
end
-- Loop through items and check flags
for _, itemType in pairs(itemTypes) do
    for _, item in pairs(data.raw[itemType]) do
        local shouldChange = true
        if item.flags then
            for _, flag in ipairs(item.flags) do
                if table.contains(possibleFlags, flag) then
                    if flag == "not-stackable" then
                        item.stack_size = 1
                        shouldChange = false
                        break
                    end
                end
            end
        end
        if shouldChange then
            item.stack_size = newStackSize
            item.default_request_amount = newDefReqSize
        end
    end
end
-- SE
if mods["space-exploration"] then
	data.raw.item["rocket-fuel"].stack_size = 10
end