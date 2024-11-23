local item_sounds = require("__base__.prototypes.item_sounds")

-- prototypes/item/items.lua
data:extend({
    {
        type = "item",
        name = "crushed-promethium-asteroid-chunk",
        icon = "__helioss__/graphics/icons/crushed-promethium-asteroid-chunk.png", 
        icon_size = 64,
        subgroup = "intermediate-product",
        order = "b[crushed-promethium-asteroid-chunk]",
        stack_size = 100,
        inventory_move_sound = item_sounds.resource_inventory_move,
        pick_sound = item_sounds.resource_inventory_pickup,
        drop_sound = item_sounds.resource_inventory_move,
    }
})