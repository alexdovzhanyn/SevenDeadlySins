class Player < Humanoid
  attr_accessor :health_text, :inventory

  MOVEMENT_SPEED = 2
  HEIGHT = 24
  WIDTH = 12
  
  def initialize(opts={})
    super(opts)

    GameText.new({x: 10, y: 10, z: 0, font: GAME_FONT, text: opts[:name] || 'Player', fixed_position: true})
    @health_text = GameText.new({x: 10, y: 30, z: 0, font: GAME_FONT, text: opts[:health], fixed_position: true})
    @velocityY = 0
    @health = opts[:health]
    @inventory = Inventory.new

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

  def interact
    Application.get(:window).objects.select{|object| object.kind_of? Interactable}.each do |object|
      if self.collision_box.x < object.x + object.width && self.collision_box.x + self.collision_box.width > object.x && self.collision_box.y < object.y + object.height && self.collision_box.height + self.collision_box.y > object.y
        object.action
      end
    end
  end


  # Player inventory ----------------------------------------------------------------------------------------------------------
  class Inventory
    attr_accessor :items, :open
    
    def initialize
      @items = []
      @open = false
    end

    def toggle
      if self.open
        self.open = false
        @background.remove
      else
        self.open = true
        @background = InterfaceImage.new({
          x: units_to_pixels(WINDOW_WIDTH/2 - 130/2), 
          y: units_to_pixels(WINDOW_HEIGHT/2 - 92/2), 
          width: units_to_pixels(130), 
          height: units_to_pixels(92), 
          z: 100, 
          # color: [0,0,0,0.7], 
          path: './assets/interface/inventory.png'
        })
      end
    end

    

  end
end