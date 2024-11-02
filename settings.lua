data:extend({
	{
        type = "bool-setting",
        name = "enable-stack-size-multiplier",
		order = "aa",
        setting_type = "startup",
        default_value = false,
    },
	{
		type = "double-setting",
		name = "stack-size-multiplier",
		order = "ab",
		setting_type = "startup",
		default_value = 1,
		minimum_value = 1,
		maximum_value = 1000,
    },
	{
		type = "double-setting",
		name = "all-items-stacks-def-req",
		order = "ac",
		setting_type = "startup",
		default_value = 200,
		minimum_value = 0,
		maximum_value = 10000,
	},
	{
		type = "int-setting",
		name = "all-items-stacks",
		order = "ad",
		setting_type = "startup",
		default_value = 1000,
		minimum_value = 1,
		maximum_value = 10000,
    },
	{
		type = "string-setting",
		name = "all-item-types",
		order = "ae",
		setting_type = "startup",
		default_value = "item, ammo, capsule, module, tool, repair-tool, item-with-entity-data, rail-planner, rail-signal, rail-chain-signal, gun",
		allow_blank = true,
	}
})