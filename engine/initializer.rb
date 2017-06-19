# Game libraries
require 'ruby2d'
require 'pry'
require 'observer'

# Core
require_relative 'helpers'
require_relative '../models/base/game_mouse'
require_relative 'camera'
require_relative '../models/base/interface_rectangle'
require_relative '../models/base/interface_image'
require_relative '../models/base/humanoid'
require_relative '../models/base/collision_box'
require_relative '../models/base/tile'
require_relative '../models/base/game_text'
require_relative '../models/base/interactable'
require_relative '../models/base/collidable'
require_relative '../models/base/platform'
require_relative '../levels/level'
require_relative '../models/entities/player'
require_relative '../models/base/item'
require_relative '../models/base/weapon'

# All other models
Dir["./models/*.rb"].each {|file| require file }
Dir["./models/entities/*.rb"].each {|file| require file }
Dir["./models/controllers/*.rb"].each {|file| require file }
Dir["./models/*/*/*.rb"].each {|file| require file }

# Load levels
Dir["./levels/*.rb"].each {|file| require file }

# ETC
require_relative 'updater'
require_relative 'controls'

# Initialize game
WINDOW_WIDTH = 256
WINDOW_HEIGHT = 144
GRAVITY = 0.6
GAME_FONT = './assets/fonts/LCD_Solid.ttf'

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

$mouse = GameMouse.new({
	x: 0,
	y: 0,
	z: 100,
	width: 0,
	height: 0,
	color: [0,0,0,0]
})

$entities = []
$interface_controller = InterfaceController.new
$skybox = Skybox.new(x: 0, y: 0, z: -10, path: './assets/backgrounds/town.png')
$skybox.width = units_to_pixels($skybox.width)
$skybox.height = units_to_pixels($skybox.height)

$game_end_bg = Rectangle.new(x: 0, y: 0, z: 100000, width: units_to_pixels(WINDOW_WIDTH), height: units_to_pixels(WINDOW_HEIGHT), color: [0,0,0,0])
$game_end_text = GameText.new({x: units_to_pixels(WINDOW_WIDTH/2), y: units_to_pixels(WINDOW_HEIGHT/2), z: 100001, font: GAME_FONT, text: 'You Died :(', color: [1,0,0,0], size: 80})