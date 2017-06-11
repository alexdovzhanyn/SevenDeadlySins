class Player < Image

  attr_accessor :jumping, :velocityY, :current_platform, :health, :health_text

  MOVEMENT_SPEED = 2
  JUMP_SPEED = 20
  HEIGHT = 24
  WIDTH = 12
  
  def initialize(opts={})
    super(opts)

    GameText.new({x: 10, y: 10, z: 0, font: './assets/fonts/Ubuntu-B.ttf', text: opts[:name] || 'Player', fixed_position: true})
    @health_text = GameText.new({x: 10, y: 30, z: 0, font: './assets/fonts/Ubuntu-B.ttf', text: opts[:health], fixed_position: true})
    @jumping = false
    @velocityY = 0
    @health = opts[:health]

    self.width = units_to_pixels(self.width)
    self.height = units_to_pixels(self.height)
    self.z = opts[:z]
  end

  def move_left
    # Disable player movement if they are triggering the camera to move, so that the player can never
    # accidentally cause infinite walking
    unless self.x < 500
      self.x -= units_to_pixels(MOVEMENT_SPEED)
    end
  end

  def move_right
    # Disable player movement if they are triggering the camera to move, so that the player can never
    # accidentally cause infinite walking
    unless self.x + self.width > units_to_pixels(WINDOW_WIDTH) - 500
      self.x += units_to_pixels(MOVEMENT_SPEED)
    end
  end

  def toggle_jump(platform)
    self.y -= 15 + ((self.y + self.height) - platform.y)
    self.velocityY = 15
  end

  def drop_from_platform(platform)
    self.y += platform.height
  end

  def colliding?
    # Returns false or the object a player is colliding with.
    # Needs to be updated for handling multiple collisions at once
    Application.get(:window).objects.select{|object| object.kind_of? Collidable}.each do |object|
      if self.x < object.x + object.width && self.x + self.width > object.x && self.y < object.y + object.height && self.height + self.y > object.y
        return object
      end
    end

    return false
  end
end