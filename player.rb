class Player < Rectangle
  MOVEMENT_SPEED = 10
  JUMP_SPEED = 20
  HEIGHT = 120
  WIDTH = 60
  
  attr_accessor :jumping, :velocityY, :current_platform, :health, :health_text

  def initialize(opts={})
    super(opts)

    Text.new({x: 10, y: 10, z: 0, font: '/usr/share/fonts/truetype/ubuntu-font-family/Ubuntu-B.ttf', text: opts[:name] || 'Player'})
    @health_text = Text.new({x: 10, y: 30, z: 0, font: '/usr/share/fonts/truetype/ubuntu-font-family/Ubuntu-B.ttf', text: opts[:health]})
    @jumping = false
    @velocityY = 0
    @health = opts[:health]
  end

  def move_left
    # Prevent from walking off of level
    unless self.x <= 0
      self.x -= MOVEMENT_SPEED
    end
  end

  def move_right
    self.x += MOVEMENT_SPEED
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