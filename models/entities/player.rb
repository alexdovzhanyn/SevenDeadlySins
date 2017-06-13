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

  def toggle_jump
    self.y -= 15
    self.velocityY = 15
  end

  def drop_from_platform(platform)
    self.y += platform.height
  end

  def can_move(direction)
    direction_map = {
      up: 'top',
      right: 'right',
      down: 'bottom',
      left: 'left'
    }

    allowed = true

    if self.colliding?
      self.colliding?.each do |collision|
        unless collision[:side] != direction_map[direction] || collision[:object].respond_to?(:prevent_collision) && collision[:object].prevent_collision
          allowed = false
        end
      end
    end

    return allowed
  end

  def colliding?
    # Returns false or the objects a player is colliding with.
    objects = []
    Application.get(:window).objects.select{|object| object.kind_of? Collidable}.each do |object|
      if self.x < object.x + object.width && self.x + self.width > object.x && self.y < object.y + object.height && self.height + self.y > object.y
        if (self.y <= object.y + 1) && (self.y + self.height <= object.y + 1)
          objects << {object: object, side: 'bottom'}
        elsif (self.y.ceil >= object.y) && (self.y.ceil >= object.y + object.height)
          objects << {object: object, side: 'top'}
        elsif (self.x > object.x) && (self.x + self.width > object.x + object.width)
          objects << {object: object, side: 'left'}
        elsif (self.x < object.x) && (self.x + self.width < object.x + object.width)
          objects << {object: object, side: 'right'} 
        end

      end
    end

    return objects.empty? ? false : objects
  end
end