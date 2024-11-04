data:extend({
	{
        type = "bool-setting",
        name = "sm-enable-stack-size-multiplier",
		order = "aa",
        setting_type = "startup",
        default_value = true,
	},
	{
		type = "int-setting",
		name = "sm-stack-size-multiplier",
		order = "ab",
		setting_type = "startup",
		default_value = 5,
		minimum_value = 1,
		maximum_value = 1000,
    },
	{
		type = "int-setting",
		name = "sm-items-def-req",
		order = "ac",
		setting_type = "startup",
		default_value = 2,
		minimum_value = 0,
		maximum_value = 10000,
	},
	{
		type = "int-setting",
		name = "sm-items-stacks",
		order = "ad",
		setting_type = "startup",
		default_value = 1000,
		minimum_value = 1,
		maximum_value = 10000,
    },
	{
        type = "bool-setting",
        name = "sm-enable-type",
		order = "ae",
        setting_type = "startup",
        default_value = true,
	},
	{
		type = "string-setting",
		name = "sm-item-types",
		order = "af",
		setting_type = "startup",
		default_value = "item, ammo, capsule, module, tool, repair-tool, item-with-entity-data, rail-planner, rail-signal, rail-chain-signal, gun",
		allow_blank = true
	},
	{
        type = "bool-setting",
        name = "sm-enable-name",
		order = "ag",
        setting_type = "startup",
        default_value = true,
	},
	{
		type = "string-setting",
		name = "sm-item-names",
		order = "ah",
		setting_type = "startup",
		default_value = "barrel, iron-ore, copper-ore, coal, uranium-ore",
		allow_blank = true
	},
	{
        type = "bool-setting",
        name = "sm-enable-rewrite",
		order = "ai",
        setting_type = "startup",
        default_value = true,
	}
})
if mods["space-age"] then
	data:extend({
		{
			type = "bool-setting",
			name = "sm-enable-weight",
			order = "ba",
			setting_type = "startup",
			default_value = false,
		},
		{
			type = "double-setting",
			name = "sm-weight",
			order = "bb",
			setting_type = "startup",
			default_value = 0.2,
			minimum_value = 0.10,
			maximum_value = 1000,
		},
		{
			type = "bool-setting",
			name = "sm-if-weight",
			order = "bc",
			setting_type = "startup",
			default_value = true,
		},
		{
			type = "string-setting",
			name = "sm-weight-item-names",
			order = "bd",
			setting_type = "startup",
			default_value = "barrel, iron-ore, copper-ore, coal, uranium-ore",
			allow_blank = true
		},
		{
			type = "string-setting",
			name = "sm-weight-item-types",
			order = "be",
			setting_type = "startup",
			default_value = "item, ammo, capsule, module, tool, repair-tool, item-with-entity-data, rail-planner, rail-signal, rail-chain-signal, gun",
			allow_blank = true
		}
	})
end