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
        break
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
        $interface_controller.remove_item(self)
      else
        self.open = true
        $interface_controller.add_item(self)
        @background = InterfaceImage.new({
          x: units_to_pixels(106), 
          y: units_to_pixels(WINDOW_HEIGHT/2 - 92/2), 
          width: units_to_pixels(130), 
          height: units_to_pixels(92), 
          z: 100,
          path: './assets/interface/inventory.png'
        })

        @slots = []

        offset_x = 0
        offset_y = 0
        56.times do |i|
          if i > 0 && i % 7 == 0
            offset_x = 0
            offset_y += 11
          end

          @slots << ContainerSlot.new({
            x: @background.x + units_to_pixels(3 + offset_x), 
            y: @background.y + units_to_pixels(3 + offset_y), 
            z: @background.z + 1, 
            width: units_to_pixels(9), 
            height: units_to_pixels(9),
            fixed_position: true,
            color: [0,0,0,0],
            item: self.items[i] ? self.items[i] : nil,
            mouseover: ->() {
              @slots[i].color = [1,1,1,0.2]
              if @slots[i].item && !@tooltip
                @tooltip = GameText.new({
                  x: @slots[i].x + @slots[i].width + 10, 
                  y: @slots[i].y, 
                  z: @slots[i].z + 6,
                  text: @slots[i].item.name,
                  font: GAME_FONT,
                  size: 12,
                  fixed_position: true
                })
              end
            },
            mouseleave: ->() {
              @slots[i].color = [0,0,0,0]
              if @tooltip
                @tooltip.remove
                @tooltip = nil
              end
            }, 
            mouseclick: ->() {
              if @slots[i].item
                self.items.delete_at(i)

                if $mouse.attached_item
                  temp_item = $mouse.attached_item
                  self.items[i] = temp_item
                end

                $mouse.attached_item = @slots[i].item
                @slots[i].item = temp_item || nil

                if @tooltip
                  @tooltip.remove
                end
              elsif !@slots[i].item && $mouse.attached_item
                @slots[i].item = $mouse.attached_item
                self.items[i] = $mouse.attached_item

                $mouse.attached_item = nil
              end
            }
          })

          offset_x += 11
        end
      end
    end

    def remove_visuals
      self.open = false
      @background.remove

      @slots.each do |slot|
        if slot.item
          slot.icon.remove
        end

        slot.remove
      end

      if @tooltip
        @tooltip.remove
        @tooltip = nil
      end
    end

  end
end