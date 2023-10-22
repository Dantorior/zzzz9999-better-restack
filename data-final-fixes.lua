-- New stack size
local newStackSize = settings.startup["all-items-stacks"].value
local newDefReqStackSize = settings.startup["all-items-stacks-def-req"].value

-- Item types to update
local itemTypes = {"item", "ammo", "capsule", "module", "tool", "repair-tool", "item-with-entity-data", "rail-planner", "rail-signal", "rail-chain-signal", "gun"}

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