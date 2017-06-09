class Player < Image

  attr_accessor :jumping, :velocityY, :current_platform, :health, :health_text

  MOVEMENT_SPEED = 10
  JUMP_SPEED = 20
  HEIGHT = 120
  WIDTH = 60
  
  def initialize(opts={})
    super(opts)

    Text.new({x: 10, y: 10, z: 0, font: './assets/fonts/Ubuntu-B.ttf', text: opts[:name] || 'Player'})
    @health_text = Text.new({x: 10, y: 30, z: 0, font: './assets/fonts/Ubuntu-B.ttf', text: opts[:health]})
    @jumping = false
    @velocityY = 0
    @health = opts[:health]

    self.width = self.width * 5
    self.height = self.height * 5
  end

  def move_left
    # Disable player movement if they are triggering the camera to move, so that the player can never
    # accidentally cause infinite walking
    unless self.x < 200
      self.x -= MOVEMENT_SPEED
    end
  end

  def move_right
    # Disable player movement if they are triggering the camera to move, so that the player can never
    # accidentally cause infinite walking
    unless self.x + self.width > WINDOW_WIDTH - 500
      self.x += MOVEMENT_SPEED
    end
  end

  def toggle_jump
    self.y -= 15
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