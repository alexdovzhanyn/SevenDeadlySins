def on_platform?(entity)
  # Fetches all platforms in level and check collision against player -- room for optimization here (is it possible to only fetch nearby platforms?)
  # This collision check only cares whether the bottom of the entity is within the bounding box of the platform
  # Returns the platform if the player is on one
  bottomOfEntity = entity.height + entity.y
  Application.get(:window).objects.select{|object| object.kind_of? Platform}.each do |platform|
    if entity.x < platform.x + platform.width && entity.x + entity.width > platform.x && bottomOfEntity < platform.y + platform.height && bottomOfEntity >= platform.y
      return platform
    end
  end

  return false
end

# Currently unused collision detection
# def colliding?(rect1, rect2)
#   return rect1.x < rect2.x + rect2.width && rect1.x + rect1.width > rect2.x && rect1.y < rect2.y + rect2.height && rect1.height + rect1.y > rect2.y
# end