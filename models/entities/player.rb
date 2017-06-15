class Player < Humanoid
  attr_accessor :health_text

  MOVEMENT_SPEED = 2
  HEIGHT = 24
  WIDTH = 12
  
  def initialize(opts={})
    super(opts)

    GameText.new({x: 10, y: 10, z: 0, font: './assets/fonts/Ubuntu-B.ttf', text: opts[:name] || 'Player', fixed_position: true})
    @health_text = GameText.new({x: 10, y: 30, z: 0, font: './assets/fonts/Ubuntu-B.ttf', text: opts[:health], fixed_position: true})
    @velocityY = 0
    @health = opts[:health]

    $entities << self
  end

  def move_left
    # Disable player movement if they are triggering the camera to move, so that the player can never
    # accidentally cause infinite walking
    unless self.collision_box.x < 500
      self.collision_box.x -= units_to_pixels(MOVEMENT_SPEED)
    end
  end

  def move_right
    # Disable player movement if they are triggering the camera to move, so that the player can never
    # accidentally cause infinite walking
    unless self.collision_box.x + self.collision_box.width > units_to_pixels(WINDOW_WIDTH) - 500
      self.collision_box.x += units_to_pixels(MOVEMENT_SPEED)
    end
  end

  def toggle_jump
    self.collision_box.y -= 15
    self.collision_box.velocityY = 15
  end

  def drop_from_platform(platform)
    self.collision_box.y += platform.height
  end
end