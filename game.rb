require 'ruby2d'
require 'pry'

require_relative 'player'

WINDOW = {
  width: 1240,
  height: 600
}

BASE_HEIGHT = 25
UPDATE_EVERY_FRAMES = 1 

set ({
  title: 'Game',
  width: WINDOW[:width],
  height: WINDOW[:height],
  background: 'gray'
})

$player = Player.new({x: (WINDOW[:width]/2 - Player::WIDTH/2), y: (WINDOW[:height] - BASE_HEIGHT * 2 - Player::HEIGHT), z: 0, height: Player::HEIGHT, width: Player::WIDTH, color: 'red'})
$base = Rectangle.new({x: 0, y: (WINDOW[:height] - BASE_HEIGHT), z: 0, height: BASE_HEIGHT, width: WINDOW[:width], color: 'blue'})

update do
  update_player
end

def gravity_pull(entity)
  if !colliding?(entity, $base)
    entity.y += 10
  end
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
      unless $player.jumping || !colliding?($player, $base)
        $player.toggle_jump
      end
  end
end

on :key_held do |e|
  case e.key
    when 'a'
      $player.move_left
    when 'd'
      $player.move_right
  end
end

show

