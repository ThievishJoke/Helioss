data:extend(
{
  {
      type = "technology",
      name = "planet-discovery-helioss",
      icons = util.technology_icon_constant_planet("__helioss__/graphics/technology/helioss.png"),
      icon_size = 256,
      essential = true,
      effects =
      {
        {
          type = "unlock-space-location",
          space_location = "helioss",
          use_icon_overlay_constant = true
        }
      },
      prerequisites = {"planet-discovery-aquilo"},
      {"metallurgic-science-pack"},
      {"agricultural-science-pack"},
      {"electromagnetic-science-pack"},
      {"cryogenic-science-pack"},
      unit =
      {
        count = 750,
        ingredients =
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
          {"production-science-pack", 1},
          {"utility-science-pack", 1},
          {"space-science-pack", 1},
          {"metallurgic-science-pack", 1},
          {"agricultural-science-pack", 1},
          {"electromagnetic-science-pack", 1},
          {"cryogenic-science-pack", 1}
        },
        time = 60
      }
  },
  {
    type = "technology",
    name = "palusium-crushing",
    icon = "__terrapalus__/graphics/technology/palusium-crushing.png",
    icon_size = 256,
    prerequisites = {""},
    effects = {
        {
            type = "unlock-recipe",
            recipe = "palusium-crushing"
        }
    },
    unit = {
        count = 150,
        ingredients = {
            {"automation-science-pack", 1},
            {"space-science-pack", 1},
            {"chemical-science-pack", 1},
            {"military-science-pack", 1}
        },
        time = 30
    }
  },
})