# Game libraries
require 'ruby2d'
require 'pry'

# Core
require_relative 'helpers'
require_relative 'camera'
require_relative '../models/base/tile'
require_relative '../models/base/game_text'
require_relative '../models/base/collidable'
require_relative '../models/base/platform'
require_relative '../levels/level'
require_relative '../models/entities/player'

# All other models
Dir["./models/*.rb"].each {|file| require file }
Dir["./models/entities/*.rb"].each {|file| require file }

# Load levels
Dir["./levels/*.rb"].each {|file| require file }

# ETC
require_relative 'updater'
require_relative 'controls'

# Initialize game
WINDOW_WIDTH = 256
WINDOW_HEIGHT = 144
GRAVITY = 0.6

BASE_HEIGHT = 5

set({
  title: 'Seven Deadly Sins',
  width: units_to_pixels(WINDOW_WIDTH),
  height: units_to_pixels(WINDOW_HEIGHT),
  background: '#99ccff'
})

$camera = Camera.new({
  x: 0,
  y: 0,
  width: units_to_pixels(WINDOW_WIDTH),
  height: units_to_pixels(WINDOW_HEIGHT)
})

$skybox = Skybox.new(x: 0, y: 0, z: -10, path: './assets/backgrounds/town.png')
$skybox.width = units_to_pixels($skybox.width)
$skybox.height = units_to_pixels($skybox.height)

$game_end_bg = Rectangle.new(x: 0, y: 0, z: 100000, width: units_to_pixels(WINDOW_WIDTH), height: units_to_pixels(WINDOW_HEIGHT), color: [0,0,0,0])
$game_end_text = GameText.new({x: units_to_pixels(WINDOW_WIDTH/2), y: units_to_pixels(WINDOW_HEIGHT/2), z: 100001, font: './assets/fonts/Ubuntu-B.ttf', text: 'You Died :(', color: [1,0,0,0], size: 80})