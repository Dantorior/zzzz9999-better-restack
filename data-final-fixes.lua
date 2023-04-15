-- Define the new stack size
local newStackSize = settings.startup["all-items-stacks"].value

-- Define the table of item types to update
local itemTypes = {"item", "ammo", "capsule", "module", "tool", "repair-tool", "item-with-entity-data"}

-- Loop through all items of each type and set their stack size
for _, itemType in pairs(itemTypes) do
  for _, item in pairs(data.raw[itemType]) do
    item.stack_size = newStackSize
  end
end
