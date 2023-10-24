-- New stack size
local newStackSize = settings.startup["all-items-stacks"].value

-- New default request size
local newDefReqStackSize = settings.startup["all-items-stacks-def-req"].value

-- Item types to update
local typesString = settings.startup["all-item-types"].value

-- Set for item types
local itemTypes = {}

-- Extracting individual types from the string
for typeStr in typesString:gmatch("[^%s,]+") do
    table.insert(itemTypes, typeStr)
end

-- Loop through all items of each type and set their stack size
for _, itemType in pairs(itemTypes) do
  for _, item in pairs(data.raw[itemType]) do
    item.stack_size = newStackSize
	item.default_request_amount = newDefReqStackSize
  end
end

-- SE
if mods["space-exploration"] then
	data.raw.item["rocket-fuel"].stack_size = 10
end

-- ATO
-- if mods["all-the-overhaul-modpack"] then
-- end