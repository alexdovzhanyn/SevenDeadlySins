# Game libraries
require 'ruby2d'
require 'pry'
require 'observer'

# Core
require_relative 'save_manager'
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

existing_saves = SaveManager.find_existing_saves

$entities = []
$level = Town.new

if !existing_saves.empty?
  save = SaveManager.load(existing_saves[0])

  $player = Player.new({
    x: pixels_to_units(save[:player][:x]),
    y: pixels_to_units(save[:player][:y]),
    z: save[:player][:z],
    health: save[:player][:health],
    path: './assets/sprites/theus.png',
    name: save[:player][:name]
  })

  $player.inventory.items = Marshal::load(save[:player][:inventory][:items])
else
  $player = Player.new({
    x: $level.spawn_point[:x], 
    y: $level.spawn_point[:y] - Player::HEIGHT, 
    z: 5, 
    health: 100,
    path: './assets/sprites/theus.png',
    name: 'Theus'
  })
end

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

$interface_controller = InterfaceController.new
$skybox = Skybox.new(x: 0, y: 0, z: -10, path: './assets/backgrounds/town1.png')
$skybox.width = units_to_pixels($skybox.width)
$skybox.height = units_to_pixels($skybox.height)

$game_end_bg = Rectangle.new(x: 0, y: 0, z: 100000, width: units_to_pixels(WINDOW_WIDTH), height: units_to_pixels(WINDOW_HEIGHT), color: [0,0,0,0])
$game_end_text = GameText.new({x: units_to_pixels(WINDOW_WIDTH/2), y: units_to_pixels(WINDOW_HEIGHT/2), z: 100001, font: GAME_FONT, text: 'You Died :(', color: [1,0,0,0], size: 80})



