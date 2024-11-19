-- Define the asteroid properties
local function custom_asteroid_variation(asteroid_type, variation_id, graphics_scale, asteroid_size)
    return {
      filename = "__modname__/graphics/entity/asteroids/" .. asteroid_type .. "_" .. variation_id .. ".png",
      priority = "extra-high",
      width = graphics_scale * 64,
      height = graphics_scale * 64,
      scale = graphics_scale,
      draw_as_shadow = false,
      apply_runtime_tint = false,
      size = asteroid_size
    }
  end
  local function create_custom_asteroid(asteroid_type, asteroid_size_name, graphics_scale, asteroid_size)
    local variations = {}
    -- Define variations for each size
    if asteroid_size_name == "chunk" then
      table.insert(variations, custom_asteroid_variation(asteroid_type, "01", graphics_scale, asteroid_size))
      table.insert(variations, custom_asteroid_variation(asteroid_type, "02", graphics_scale, asteroid_size))
      table.insert(variations, custom_asteroid_variation(asteroid_type, "03", graphics_scale, asteroid_size))
    elseif asteroid_size_name == "small" then
      table.insert(variations, custom_asteroid_variation(asteroid_type, "01", graphics_scale, asteroid_size))
      table.insert(variations, custom_asteroid_variation(asteroid_type, "02", graphics_scale, asteroid_size))
      table.insert(variations, custom_asteroid_variation(asteroid_type, "04", graphics_scale, asteroid_size))
    elseif asteroid_size_name == "medium" then
      table.insert(variations, custom_asteroid_variation(asteroid_type, "02", graphics_scale, asteroid_size))
      table.insert(variations, custom_asteroid_variation(asteroid_type, "05", graphics_scale, asteroid_size))
      table.insert(variations, custom_asteroid_variation(asteroid_type, "06", graphics_scale, asteroid_size))
    elseif asteroid_size_name == "big" then
      table.insert(variations, custom_asteroid_variation(asteroid_type, "03", graphics_scale, asteroid_size))
      table.insert(variations, custom_asteroid_variation(asteroid_type, "05", graphics_scale, asteroid_size))
      table.insert(variations, custom_asteroid_variation(asteroid_type, "07", graphics_scale, asteroid_size))
    elseif asteroid_size_name == "huge" then
      table.insert(variations, custom_asteroid_variation(asteroid_type, "04", graphics_scale, asteroid_size))
      table.insert(variations, custom_asteroid_variation(asteroid_type, "06", graphics_scale, asteroid_size))
      table.insert(variations, custom_asteroid_variation(asteroid_type, "08", graphics_scale, asteroid_size))
    end
    -- Return the asteroid definition
    return {
      type = "simple-entity",
      name = "custom-asteroid-" .. asteroid_type .. "-" .. asteroid_size_name,
      icon = "__modname__/graphics/icons/" .. asteroid_type .. ".png",
      icon_size = 64,
      flags = {"placeable-neutral", "placeable-off-grid"},
      subgroup = "asteroids",
      order = "a[" .. asteroid_type .. "]-b[" .. asteroid_size_name .. "]",
      collision_box = {{-asteroid_size / 2, -asteroid_size / 2}, {asteroid_size / 2, asteroid_size / 2}},
      selection_box = {{-asteroid_size / 2, -asteroid_size / 2}, {asteroid_size / 2, asteroid_size / 2}},
      render_layer = "object",
      max_health = asteroid_size * 10,
      pictures = variations
    }
  end
  -- Create all custom asteroid entities
  local asteroids = {}
  local asteroid_types = {"crystal", "lava", "frozen"}
  local asteroid_sizes = {
    {name = "chunk", size = 1},
    {name = "small", size = 2},
    {name = "medium", size = 3},
    {name = "big", size = 4},
    {name = "huge", size = 5}
  }
  for _, asteroid_type in ipairs(asteroid_types) do
    for _, asteroid_size in ipairs(asteroid_sizes) do
      table.insert(
        asteroids,
        create_custom_asteroid(asteroid_type, asteroid_size.name, 0.5 * asteroid_size.size, asteroid_size.size)
      )
    end
  end
  -- Register the custom asteroids
  data:extend(asteroids)