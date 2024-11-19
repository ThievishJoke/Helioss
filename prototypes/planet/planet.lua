local planet_map_gen = require("prototypes.planet.planet-helioss-map-gen")
local effects = require("__core__.lualib.surface-render-parameter-effects")
local asteroid_util = require("__space-age__.prototypes.planet.asteroid-spawn-definitions")
local planet_catalogue_aquilo = require("__space-age__.prototypes.planet.procession-catalogue-aquilo")
-- local temperature = settings.startup["surface-temperature"].value
local pressure = settings.startup["surface-pressure"].value
-- local gravity = settings.startup["surface-gravity"].value

--  ClassLuaSpaceLocationPrototype
-- https://lua-api.factorio.com/latest/classes/LuaSpaceLocationPrototype.html

data:extend(
{
    {
        type = "planet",
        name = "helioss",
        icon = "__helioss__/graphics/icons/helioss.png",
        starmap_icon = "__helioss__/graphics/icons/starmap-planet-helioss.png",
        starmap_icon_size = 512,
        gravity_pull = 0,
        distance = 30,
        orientation = 0.172,
        magnitude = 0.6,
        order = "c[helioss]",
        subgroup = "planets",
        map_gen_settings = planet_map_gen.helioss(),
        pollutant_type = nil,
        solar_power_in_space = 35,
        auto_save_on_first_trip = true,
        platform_procession_set = {
            arrival = {"planet-to-platform-b"},
            departure = {"platform-to-planet-a"}
        },
        planet_procession_set = {
            arrival = {"platform-to-planet-b"},
            departure = {"planet-to-platform-a"}
        },
        procession_graphic_catalogue = planet_catalogue_aquilo, -- Reuse Gleba's procession graphics
        surface_properties = {
            ["day-night-cycle"] = 10 * minute,
            ["magnetic-field"] = 90,
            ["solar-power"] = 20,
            pressure = pressure,
            gravity = 7
        },
        surface_render_parameters = {
            fog = effects.default_fog_effect_properties(),
            clouds = effects.default_clouds_effect_properties(),
            -- Using Gleba's cloudscape but with different colors
            clouds_color1 = {200, 70, 255, 1.0},
            clouds_color2 = {25, 0, 255, 1.0}
        },
        asteroid_spawn_influence = 1,
        asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba, 0.9),
        persistent_ambient_sounds =
        {
          base_ambience =
          {
            {sound = {filename = "__space-age__/sound/wind/base-wind-vulcanus.ogg", volume = 0.8}}
          },
          wind = {filename = "__space-age__/sound/wind/wind-vulcanus.ogg", volume = 0.8},
          crossfade =
          {
            order = {"wind", "base_ambience"},
            curve_type = "cosine",
            from = {control = 0.35, volume_percentage = 0.2},
            to = {control = 2, volume_percentage = 100.0}
          },
          semi_persistent =
          {
            {
              sound = {variations = sound_variations("__space-age__/sound/world/semi-persistent/wind-gust", 6, 0.4)},
              delay_mean_seconds = 10,
              delay_variance_seconds = 5
            },
            {
              sound =
                {
                  filename = "__space-age__/sound/world/weather/rain.ogg", volume = 0.25,
                  advanced_volume_control = {fades = {fade_in = {curve_type = "cosine", from = {control = 0.2, volume_percentage = 0.6}, to = {1.2, 100.0 }}}}
                }
            },
            {
              sound = {variations = sound_variations("__space-age__/sound/world/semi-persistent/distant-rumble", 3, 0.5)},
              delay_mean_seconds = 10,
              delay_variance_seconds = 5
            },
            {
              sound = {variations = sound_variations("__space-age__/sound/world/semi-persistent/distant-flames", 5, 0.6)},
              delay_mean_seconds = 15,
              delay_variance_seconds = 7.0
            }
          }
        },
        player_effects =
        {
          type = "cluster",
          cluster_count = 10,
          distance = 8,
          distance_deviation = 8,
          action_delivery =
          {
            type = "instant",
            source_effects =
            {
              type = "create-trivial-smoke",
              smoke_name = "aquilo-snow-smoke",
              speed = {-0.05, 0.5},
              initial_height = 1,
              speed_multiplier = 2,
              speed_multiplier_deviation = 0.05,
              starting_frame = 2,
              starting_frame_deviation = 2,
              offset_deviation = {{-96, -56}, {96, 40}},
              speed_from_center = 0.01,
              speed_from_center_deviation = 0.02
            }
          }
        },
    },
    -- Connection to gleba
    {
      type = "space-connection",
      name = "gleba-helioss",
      subgroup = "planet-connections",
      from = "gleba",
      to = "helioss",
      order = "a",
      length = 100000,
      asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba)
    },
    -- Connection to aquilo
    {
      type = "space-connection",
      name = "aquilo-helioss",
      subgroup = "planet-connections",
      from = "aquilo",
      to = "helioss",
      order = "b",
      length = 100000,
      asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba)
    },
    -- Connection to nauvis
    {
      type = "space-connection",
      name = "nauvis-helioss",
      subgroup = "planet-connections",
      from = "nauvis",
      to = "helioss",
      order = "c",
      length = 150000,
      asteroid_spawn_definitions = asteroid_util.spawn_definitions(asteroid_util.nauvis_gleba)
    }
})