def on_platform?(entity)
  # Fetches all platforms in level and check collision against player -- room for optimization here (is it possible to only fetch nearby platforms?)
  # This collision check only cares whether the bottom of the entity is within the bounding box of the platform
  # Returns the platform if the player is on one
  bottomOfEntity = entity.height + entity.y
  Application.get(:window).objects.select{|object| object.kind_of? Collidable}.each do |object|
    if !object.prevent_collision && entity.x < object.x + object.width && entity.x + entity.width > object.x && bottomOfEntity < object.y + object.height && bottomOfEntity >= object.y
      return object
    end
  end

  return false
end

# Currently unused collision detection
# def colliding?(rect1, rect2)
#   return rect1.x < rect2.x + rect2.width && rect1.x + rect1.width > rect2.x && rect1.y < rect2.y + rect2.height && rect1.height + rect1.y > rect2.y
# end

def units_to_pixels(units)
  return units * 5
end

def pixels_to_units(pixels)
  return pixels / 5
end