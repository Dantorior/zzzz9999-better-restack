data:extend({
	{
		type = "int-setting",
		name = "all-items-stacks",
		order = "aa",
		setting_type = "startup",
		default_value = 1000,
		minimum_value = 1,
		maximum_value = 100000,
    },
	{
		type = "int-setting",
		name = "all-items-stacks-def-req",
		order = "ab",
		setting_type = "startup",
		default_value = 500,
		minimum_value = 0,
		maximum_value = 100000,
	},
	{
		type = "string-setting",
		name = "all-item-types",
		order = "ac",
		setting_type = "startup",
		default_value = "item, ammo, capsule, module, tool, repair-tool, item-with-entity-data, rail-planner, rail-signal, rail-chain-signal, gun",
		allow_blank = true
	}
})