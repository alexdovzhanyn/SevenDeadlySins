require 'ruby2d'
require 'pry'

require_relative 'levels/level'
require_relative 'player'
require_relative 'platform'

# Load levels
Dir["./levels/*.rb"].each {|file| require_relative file }

WINDOW_WIDTH = 1240
WINDOW_HEIGHT = 600

BASE_HEIGHT = 25
UPDATE_EVERY_FRAMES = 1 

set ({
  title: 'Seven Deadly Sins',
  width: WINDOW_WIDTH,
  height: WINDOW_HEIGHT,
  background: '#99ccff'
})

$player = Player.new({x: (WINDOW_WIDTH/2 - Player::WIDTH/2), y: (WINDOW_HEIGHT - BASE_HEIGHT * 2 - Player::HEIGHT), z: 1, height: Player::HEIGHT, width: Player::WIDTH, color: 'red'})
Town.new

update do
  update_player
end

def gravity_pull(entity)
  if !on_platform?(entity)
    entity.y += 10
  end
end

def on_platform?(entity)
  # Fetches all platforms in level and check collision against player -- room for optimization here (is it possible to only fetch nearby platforms?)
  # This collision check only cares whether the bottom of the entity is within the bounding box of the platform
  # Returns the platform if the player is on one
  bottomOfEntity = entity.height + entity.y
  Application.get(:window).objects.select{|object| object.class == Platform}.each do |platform|
    if entity.x < platform.x + platform.width && entity.x + entity.width > platform.x && bottomOfEntity < platform.y + platform.height && bottomOfEntity >= platform.y
      return platform
    end
  end

  return false
end

def update_player
  if $player.jumping
    $player.y -= Player::JUMP_SPEED
  else
    gravity_pull($player)
  end
end

def colliding?(rect1, rect2)
  return rect1.x < rect2.x + rect2.width && rect1.x + rect1.width > rect2.x && rect1.y < rect2.y + rect2.height && rect1.height + rect1.y > rect2.y
end

on :key_down do |e|
  case e.key
    when "a"
      $player.move_left
    when "d"
      $player.move_right
    when "space"
      unless $player.jumping || !on_platform?($player)
        $player.toggle_jump
      end
    when "left shift" 
      current_platform = on_platform?($player)
      if current_platform
        $player.drop_from_platform(current_platform)
      end
    when "right shift"
      current_platform = on_platform?($player)
      if current_platform
        $player.drop_from_platform(current_platform)
      end
  end
end

on :key_held do |e|
  case e.key
    when 'a'
      $player.move_left
    when 'd'
      $player.move_right
    when "space"
      unless $player.jumping || !on_platform?($player)
        $player.toggle_jump
      end
  end
end

show

