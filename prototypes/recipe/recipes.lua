-- prototypes/recipe/recipes.lua
data:extend({
    {
        type = "recipe",
        name = "promethium-crushing",
        category = "crushing",  
        --subgroub = "asteroid",
        order = "g[promethium-crushing]",
        enabled = true,
        ingredients = {
            {type = "item", name = "promethium-asteroid-chunk", amount = 1}
        },
        results = {
            {type = "item", name = "crushed-promethium-asteroid-chunk", amount = 4}
        },
        allow_productivity = true
    }
})