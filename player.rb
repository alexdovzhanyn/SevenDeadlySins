class Player < Rectangle
  MOVEMENT_SPEED = 10
  JUMP_SPEED = 20
  HEIGHT = 120
  WIDTH = 60
  
  attr_accessor :jumping

  def initialize(opts={})
    super(opts)

    Text.new({x: 10, y: 10, z: 0, font: '/usr/share/fonts/truetype/ubuntu-font-family/Ubuntu-B.ttf', text: opts[:name] || 'Player'})
    jumping = false
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
    self.jumping = true

    # There's probably a better way to do this
    Thread.new do
      sleep 0.2
      self.jumping = false
    end
  end

  def drop_from_platform(platform)
    self.y += platform.height
  end
end