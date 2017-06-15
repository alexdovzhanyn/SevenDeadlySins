require_relative 'engine/initializer'

$level = Town.new

$player = Player.new({
  x: $level.spawn_point[:x], 
  y: $level.spawn_point[:y] - Player::HEIGHT, 
  z: 5, 
  health: 100,
  path: './assets/sprites/theus.png',
  name: 'Theus'
})

show

