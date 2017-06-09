# Game libraries
require 'ruby2d'
require 'pry'

# Core
require_relative 'helpers'
require_relative 'camera'
require_relative '../models/base/collidable'
require_relative '../models/base/platform'
require_relative '../levels/level'
require_relative '../models/entities/player'

# All other models
Dir["./models/*.rb"].each {|file| require file }

# Load levels
Dir["./levels/*.rb"].each {|file| require file }

# ETC
require_relative 'updater'
require_relative 'controls'

# Initialize game
WINDOW_WIDTH = 1240
WINDOW_HEIGHT = 600
GRAVITY = 0.6

BASE_HEIGHT = 25

set({
  title: 'Seven Deadly Sins',
  width: WINDOW_WIDTH,
  height: WINDOW_HEIGHT,
  background: '#99ccff'
})

$camera = Camera.new({
  x: 0,
  y: 0,
  width: WINDOW_WIDTH,
  height: WINDOW_HEIGHT
})