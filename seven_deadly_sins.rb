require_relative 'engine/initializer'

$level = Town.new

$player = Player.new({
  x: $level.spawn_point[:x], 
  y: $level.spawn_point[:y] - units_to_pixels(Player::HEIGHT), 
  z: 5, 
  height: units_to_pixels(Player::HEIGHT), 
  width: units_to_pixels(Player::WIDTH), 
  # color: 'red', 
  health: 100,
  path: './assets/sprites/theus.png'
})

show

