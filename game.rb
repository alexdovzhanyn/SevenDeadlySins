require 'ruby2d'
require 'pry'

require_relative 'collidable'
require_relative 'levels/level'
require_relative 'player'
require_relative 'platform'
require_relative 'damage_block'

# Load levels
Dir["./levels/*.rb"].each {|file| require_relative file }

WINDOW_WIDTH = 1240
WINDOW_HEIGHT = 600
GRAVITY = 0.6

BASE_HEIGHT = 25

set ({
  title: 'Seven Deadly Sins',
  width: WINDOW_WIDTH,
  height: WINDOW_HEIGHT,
  background: '#99ccff'
})

$player = Player.new({x: (WINDOW_WIDTH/2 - Player::WIDTH/2), y: (WINDOW_HEIGHT - BASE_HEIGHT * 2 - Player::HEIGHT), z: 1, height: Player::HEIGHT, width: Player::WIDTH, color: 'red', health: 100})
Town.new

update do
  if $player.health > 0
    update_player
  else
    clear

    set({
      background: '#000000'
    })

    game_end_text = Text.new({x: WINDOW_WIDTH/2, y: WINDOW_HEIGHT/2, z: 0, font: '/usr/share/fonts/truetype/ubuntu-font-family/Ubuntu-B.ttf', text: 'You Died :(', color: '#ff0000', size: 80})
    

    # Reposition text after we know its height & width to center it
    game_end_text.x = WINDOW_WIDTH/2 - game_end_text.width/2
    game_end_text.y = WINDOW_HEIGHT/2 - game_end_text.height/2
  end
end

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

def update_player
  # Check to see if player should be taking damage
  colliding_object = $player.colliding?
  if colliding_object && colliding_object.respond_to?(:damage)
    $player.health -= colliding_object.damage
  end

  $player.health_text.text = $player.health
  if !on_platform?($player)
    $player.velocityY -= GRAVITY
    $player.y -= $player.velocityY
  else
    $player.velocityY = 0
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
      unless !on_platform?($player)
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
      unless !on_platform?($player)
        $player.toggle_jump
      end
  end
end

show

