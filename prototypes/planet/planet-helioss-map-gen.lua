local MapGen = {}

data:extend({
    {
        type = "noise-expression",
        name = "helioss_ore_spacing",
        expression = 128
    },
    {
        type = "noise-expression",
        name = "helioss_fertile_spots_coastal_raw",
        expression = "spot_noise{x = x + wobble_noise_x * 15,\z
                                y = y + wobble_noise_y * 15,\z
                                seed0 = map_seed,\z
                                seed1 = 1,\z
                                candidate_spot_count = 80,\z
                                suggested_minimum_candidate_point_spacing = 128,\z
                                skip_span = 1,\z
                                skip_offset = 0,\z
                                region_size = 1024,\z
                                density_expression = 80,\z
                                spot_quantity_expression = 1000,\z
                                spot_radius_expression = 32,\z
                                hard_region_target_quantity = 0,\z
                                spot_favorability_expression = 60,\z
                                basement_value = -0.5,\z
                                maximum_spot_basement_radius = 128}",
        local_expressions = {
            wobble_noise_x = "multioctave_noise{x = x, y = y, persistence = 0.5, seed0 = map_seed, seed1 = 3000000, octaves = 2, input_scale = 1/20}",
            wobble_noise_y = "multioctave_noise{x = x, y = y, persistence = 0.5, seed0 = map_seed, seed1 = 4000000, octaves = 2, input_scale = 1/20}"
        }
    },
    
    {
        type = "noise-expression",
        name = "helioss_starting_fertile",
        expression = "spot_noise{x = x + wobble_noise_x * 15,\z
                                y = y + wobble_noise_y * 15,\z
                                seed0 = map_seed,\z
                                seed1 = 2,\z
                                candidate_spot_count = 80,\z
                                suggested_minimum_candidate_point_spacing = 128,\z
                                skip_span = 1,\z
                                skip_offset = 0,\z
                                region_size = 1024,\z
                                density_expression = 80,\z
                                spot_quantity_expression = 1000,\z
                                spot_radius_expression = 32,\z
                                hard_region_target_quantity = 0,\z
                                spot_favorability_expression = 60,\z
                                basement_value = -0.5,\z
                                maximum_spot_basement_radius = 128}",
        local_expressions = {
            wobble_noise_x = "multioctave_noise{x = x, y = y, persistence = 0.5, seed0 = map_seed, seed1 = 3000000, octaves = 2, input_scale = 1/20}",
            wobble_noise_y = "multioctave_noise{x = x, y = y, persistence = 0.5, seed0 = map_seed, seed1 = 4000000, octaves = 2, input_scale = 1/20}"
        }
    },
    {
        type = "noise-expression",
        name = "helioss_fertile_spots_coastal",
        expression = "max(min(1, helioss_starting_fertile * 4), min(exclude_middle, helioss_fertile_spots_coastal_raw) - max(0, -(helioss_elevation + 2) / 5) - max(0, (helioss_elevation - 10) / 5))",
        local_expressions = {
            exclude_middle = "(distance / helioss_starting_area_multiplier / 150) - 2.2"
        }
    },
    {
        type = "noise-expression",
        name = "helioss_starting_area_multiplier",
        expression = "0.7"
    },
    {
        type = "noise-expression",
        name = "helioss_resource_wobble_x",
        expression = "helioss_wobble_x + 0.25 * helioss_wobble_large_x"
    },
    {
      type = "noise-expression",
      name = "helioss_resource_wobble_y",
      expression = "heliosss_wobble_y + 0.25 * helioss_wobble_large_y"
    },
    {
        type = "noise-expression",
        name = "helioss_starting_area_radius",
        expression = "0.7 * 0.75"
    },
    {
      type = "noise-expression",
      name = "helioss_starting_direction",
      expression = "-1 + 2 * (map_seed_small & 1)"
    },
    {
        type = "noise-expression",
        name = "helioss_ashlands_angle",
        expression = "map_seed_normalized * 3600"
      },
    {
      type = "noise-expression",
      name = "helioss_mountains_angle",
      expression = "helioss_ashlands_angle + 120 * helioss_starting_direction"
    },
    {
        type = "noise-expression",
        name = "helioss_starting_sulfur",
        expression = "max(spot_at_angle{angle = helioss_mountains_angle + 10 * helioss_starting_direction,\z
                                        distance = 590 * helioss_starting_area_radius,\z
                                        radius = 30,\z
                                        x_distortion = 0.75 * helioss_resource_wobble_x,\z
                                        y_distortion = 0.75 * helioss_resource_wobble_y},\z
                          spot_at_angle{angle = helioss_mountains_angle + 30 * helioss_starting_direction,\z
                                        distance = 200 * helioss_starting_area_radius,\z
                                        radius = 25 * helioss_sulfuric_acid_geyser_size,\z
                                        x_distortion = 0.75 * helioss_resource_wobble_x,\z
                                        y_distortion = 0.75 * helioss_resource_wobble_y})"
    },
    {
        type = "noise-function",
        name = "helioss_spot_noise",
        parameters = {"seed", "count", "spacing", "span", "offset", "region_size", "density", "quantity", "radius", "favorability"},
        expression = "spot_noise{x = x + helioss_resource_wobble_x,\z
                                 y = y + helioss_resource_wobble_y,\z
                                 seed0 = map_seed,\z
                                 seed1 = seed,\z
                                 candidate_spot_count = count,\z
                                 suggested_minimum_candidate_point_spacing = 128,\z
                                 skip_span = span,\z
                                 skip_offset = offset,\z
                                 region_size = region_size,\z
                                 density_expression = density,\z
                                 spot_quantity_expression = quantity,\z
                                 spot_radius_expression = radius,\z
                                 hard_region_target_quantity = 0,\z
                                 spot_favorability_expression = favorability,\z
                                 basement_value = -1,\z
                                 maximum_spot_basement_radius = 128}"
      },
    {
        type = "noise-function",
        name = "helioss_place_sulfur_spots",
        parameters = {"seed", "count", "offset", "size", "freq", "favor_biome"},
        expression = "min(2 * favor_biome - 1, helioss_spot_noise{seed = seed,\z
                                                                   count = count,\z
                                                                   spacing = helioss_ore_spacing,\z
                                                                   span = 3,\z
                                                                   offset = offset,\z
                                                                   region_size = 450 + 450 / freq,\z
                                                                   density = favor_biome * 4,\z
                                                                   quantity = size * size,\z
                                                                   radius = size,\z
                                                                   favorability = favor_biome > 0.9})"
    },
    {
        type = "noise-expression",
        name = "helioss_sulfuric_acid_geyser_size",
        expression = "slider_rescale(control:sulfuric_acid_geyser:size, 2)"
    },
    {
      type = "noise-expression",
      name = "helioss_sulfuric_acid_region",
      -- -1 to 1: needs a positive region for resources & decoratives plus a subzero baseline and skirt for surrounding decoratives.
      expression = "max(helioss_starting_sulfur,\z
                        min(1 - helioss_starting_circle,\z
                            helioss_place_sulfur_spots(759, 9, 0,\z
                                                        helioss_sulfuric_acid_geyser_size * min(1.2, helioss_ore_dist) * 25,\z
                                                        control:sulfuric_acid_geyser:frequency,\z
                                                        helioss_mountains_sulfur_favorability)))"
    },
    {
        type = "noise-expression",
        name = "helioss_sulfuric_acid_patches",
        -- small wavelength noise (5 tiles-ish) to make geyser placement patchy but consistent between resources and decoratives
        expression = "0.8 * abs(multioctave_noise{x = x, y = y, persistence = 0.7, seed0 = map_seed, seed1 = 21000, octaves = 2, input_scale = 1/3})"
    },
    {
      type = "noise-expression",
      name = "helioss_sulfuric_acid_region_patchy",
      expression = "(1 + helioss_sulfuric_acid_region) * (0.5 + 0.5 * helioss_sulfuric_acid_patches) - 1"
    },
    {
      type = "noise-expression",
      name = "helioss_sulfuric_acid_geyser_probability",
      expression = "(control:sulfuric_acid_geyser:size > 0) * (0.025 * ((helioss_sulfuric_acid_region_patchy > 0) + 2 * helioss_sulfuric_acid_region_patchy))"
    },
    {
      type = "noise-expression",
      name = "helioss_sulfuric_acid_geyser_richness",
      expression = "(helioss_sulfuric_acid_region > 0) * random_penalty_between(0.5, 1, 1)\z
                    * 80000 * 40 * heliosss_richness_multiplier * helioss_starting_area_multiplier\z
                    * control:sulfuric_acid_geyser:richness / helioss_sulfuric_acid_geyser_size"
    },
    {
      type = "noise-expression",
      name = "helioss_ore_dist",
      expression = "max(1, distance / 4000)"
    },
    -- Basic control expressions
    {
        type = "noise-expression",
        name = "helioss_segmentation_multiplier",
        expression = 1
    },
    -- Basic terrain noise for mixing biomes
    {
        type = "noise-expression",
        name = "helioss_biome_mix",
        expression = "clamp(multioctave_noise{x = x, y = y, persistence = 0.7, seed0 = map_seed, seed1 = 1, octaves = 3, input_scale = 1/150}, 0, 1)"
    },
    -- Moisture based on Gleba's implementation
    {
        type = "noise-expression",
        name = "helioss_moisture",
        expression = "clamp(1 - min(0.25 + (helioss_elevation / 80), 0.5 + (helioss_elevation - 20) / 400), 0, 1)"
    },
    -- Elevation mixing Nauvis and Gleba patterns
    {
        type = "noise-expression",
        name = "helioss_elevation",
        expression = "lerp(nauvis_style, gleba_style, helioss_biome_mix)",
        local_expressions = {
            nauvis_style = "100 + 50 * basic_noise",
            gleba_style = "clamp(elevation_value * 0.5 + mud_noise, -1.5, 19.9) + 0.15 * mud_noise",
            basic_noise = "multioctave_noise{x = x, y = y, persistence = 0.7, seed0 = map_seed, seed1 = 1000000, octaves = 3, input_scale = 1/60}",
            elevation_value = "150",
            mud_noise = "-8 + 16 * gleba_mud_basins"
        }
    },
    -- From Gleba's implementation
    {
        type = "noise-expression",
        name = "gleba_mud_basins",
        expression = "1 - abs(multioctave_noise{x = x, y = y, persistence = 0.7, seed0 = map_seed, seed1 = 1000000, octaves = 3, input_scale = 1/10})"
    },
    {
        type = "noise-expression",
        name = "helioss_aux",
        expression = "clamp(0.5 + basic_noise, 0, 1)",
        local_expressions = {
            basic_noise = "multioctave_noise{x = x, y = y, persistence = 0.7, seed0 = map_seed, seed1 = 1, octaves = 3, input_scale = 1/60}"
        }
    },
    
    {
        type = "noise-expression",
        name = "lava_hot_mountains_range",
        expression = "clamp(multioctave_noise{x = x, y = y, persistence = 0.7, seed0 = map_seed, seed1 = 1, octaves = 3, input_scale = 1/150}, 0, 1)"
    },
    {
        type = "noise-expression",
        name = "lava_mountains_range",
        expression = "clamp(multioctave_noise{x = x, y = y, persistence = 0.7, seed0 = map_seed, seed1 = 1, octaves = 3, input_scale = 1/150}, 0, 1)"
    },
    {
        type = "noise-expression",
        name = "helioss_aux",
        expression = "clamp(0.5 + basic_noise, 0, 1)",
        local_expressions = {
            basic_noise = "multioctave_noise{x = x, y = y, persistence = 0.7, seed0 = map_seed, seed1 = 1, octaves = 3, input_scale = 1/60}"
        }
    },
    {
        type = "noise-expression",
        name = "helioss_temperature",
        expression = "14 + 6 * basic_noise",
        local_expressions = {
            basic_noise = "multioctave_noise{x = x, y = y, persistence = 0.7, seed0 = map_seed, seed1 = 2, octaves = 3, input_scale = 1/60}"
        }
    }
})

function MapGen.helioss()
    return {
        property_expression_names = {
            elevation = "helioss_elevation",
            temperature = "helioss_temperature",
            moisture = "helioss_moisture",
            aux = "helioss_aux",
            cliffiness = "cliffiness_basic",
            cliff_elevation = "cliff_elevation_from_elevation"
        },
        autoplace_controls = {
            ["iron-ore"] = {},
            ["copper-ore"] = {},
            ["gleba_water"] = {},
            ["stone"] = {},
            ["sulfuric_acid_geyser"] = {},
            ["vulcanus_volcanism"] = {},
            ["water"] = {}
        },
        autoplace_settings = {
            ["tile"] = {
                settings = {
                    ["dirt-1"] = {
                        frequency = 0.1,
                        size = 0.3
                    },
                    ["dirt-2"] = {
                        frequency = 0.1,
                        size = 0.3
                    },
                    ["dirt-3"] = {
                        frequency = 0.1,
                        size = 0.3
                    },
                    ["dirt-4"] = {
                        frequency = 0.1,
                        size = 0.3
                    },
                    ["volcanic-ash-cracks"] = {},
                    ["volcanic-ash-dark"] = {
                        frequency = 0.4,
                        size = 0.6
                    },
                    ["volcanic-ash-flats"] = {},
                    ["volcanic-ash-light"] = {},
                    ["volcanic-ash-soil"] = {
                        frequency = 0.4,
                        size = 0.6
                    },
                    ["volcanic-cracks"] = {},
                    ["volcanic-cracks-hot"] = {},
                    ["volcanic-cracks-warm"] = {},
                    ["volcanic-folds"] = {},
                    ["volcanic-folds-flat"] = {},
                    ["volcanic-folds-warm"] = {},
                    ["volcanic-jagged-ground"] = {
                        frequency = 0.35,
                        size = 0.3
                    },
                    ["volcanic-pumice-stones"] = {},
                    ["volcanic-smooth-stone"] = {},
                    ["volcanic-smooth-stone-warm"] = {},
                    ["volcanic-soil-dark"] = {
                        frequency = 0.4,
                        size = 0.6
                    },
                    ["volcanic-soil-light"] = {
                        frequency = 0.6,
                        size = 0.4
                    },
                    ["red-desert-0"] = {
                        frequency = 0.3,
                        size = 0.4
                    },
                    ["water"] = {
                        frequency = 2.5,
                        size = 9.0
                    },
                    ["deepwater"] = {},
                    ["gleba-deep-lake"] = {
                        frequency = 1.4,
                        size = 15.6
                    }
                }
            },
            ["decorative"] = {
                settings = {
                    ["vulcanus-rock-decal-large"] = {},
                    ["vulcanus-crack-decal-large"] = {},
                    ["vulcanus-crack-decal-huge-warm"] = {},
                    ["vulcanus-dune-decal"] = {},
                    ["vulcanus-sand-decal"] = {},
                    ["vulcanus-lava-fire"] = {},
                    ["vulcanus-crack-decal"] = {},
                    ["waves-decal"] = {},
                    ["sulfur-rock-cluster"] = {},
                    ["sulfur-stain"] = {},
                    ["sulfur-stain-small"] = {},
                    ["sulfuric-acid-puddle"] = {},
                    ["sulfuric-acid-puddle-small"] = {},
                    ["crater-small"] = {},
                    ["crater-large"] = {},
                    ["tiny-sulfur-rock"] = {},
                    ["light-mud-decal"] = {},
                    ["dark-mud-decal"] = {},
                    ["cracked-mud-decal"] = {},
                }
            },
            ["entity"] = {
                settings = {
                    ["iron-ore"] = {},
                    ["stone"] = {},
                    ["sulfuric-acid-geyser"] = {},
                    ["ashland-lichen-tree"] = {},
                    ["ashland-lichen-tree-flaming"] = {},
                    ["big-volcanic-rock"] = {},
                    ["huge-volcanic-rock"] = {},
                    ["vulcanus-chimney"] = {},
                    ["vulcanus-chimney-cold"] = {},
                    ["vulcanus-chimney-faded"] = {},
                    ["vulcanus-chimney-short"] = {},
                    ["vulcanus-chimney-truncated"] = {}
                }
            }
        },
        cliff_settings = {
            name = "cliff-vulcanus",
            cliff_elevation_0 = 40,
            cliff_elevation_interval = 35
        }
    }
end

return MapGen