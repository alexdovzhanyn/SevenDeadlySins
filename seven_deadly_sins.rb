require_relative 'engine/initializer'

$level = Town.new

$player = Player.new({
  x: $level.spawn_point[:x], 
  y: $level.spawn_point[:y] - Player::HEIGHT, 
  z: 1, 
  height: Player::HEIGHT, 
  width: Player::WIDTH, 
  color: 'red', 
  health: 100
})

$game_end_bg = Rectangle.new(x: 0, y: 0, z: 2, width: WINDOW_WIDTH, height: WINDOW_HEIGHT, color: [0,0,0,0])
$game_end_text = Text.new({x: WINDOW_WIDTH/2, y: WINDOW_HEIGHT/2, z: 3, font: './assets/fonts/Ubuntu-B.ttf', text: 'You Died :(', color: [1,0,0,0], size: 80})

show

