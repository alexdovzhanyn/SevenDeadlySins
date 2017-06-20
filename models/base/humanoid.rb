class Humanoid
	attr_accessor :collision_box, :sprite, :health, :name

	def initialize(opts={})
		opts[:x] = units_to_pixels(opts[:x])
		opts[:y] = units_to_pixels(opts[:y])

		@movement_speed = opts[:movement_speed]

		@sprite = Image.new(opts)
		@sprite.width = units_to_pixels(@sprite.width)
		@sprite.height = units_to_pixels(@sprite.height)

		@collision_box = CollisionBox.new({x: opts[:x], y: opts[:y] - @sprite.height, z: opts[:z], width: @sprite.width, height: @sprite.height})
		@collision_box.add_observer(self, :update_sprite)

		@name = opts[:name]
		@name_text = GameText.new({x: @sprite.x, y: @sprite.y - 50, z: @sprite.z, text: @name, color: 'white', font: GAME_FONT})
		@name_text.x = (@sprite.x + @sprite.width/2) - @name_text.width/2
	end

	def update_sprite(collision_box)
		self.sprite.x = collision_box.x
		self.sprite.y = collision_box.y
		@name_text.x = (self.sprite.x + self.sprite.width/2) - @name_text.width/2 
		@name_text.y = self.sprite.y - 50
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
      if self.collision_box.x < object.x + object.width && self.collision_box.x + self.collision_box.width > object.x && self.collision_box.y < object.y + object.height && self.collision_box.height + self.collision_box.y > object.y
        if (self.collision_box.y <= object.y + 1) && (self.collision_box.y + self.collision_box.height <= object.y + 1)
          objects << {object: object, side: 'bottom'}
        elsif (self.collision_box.y.ceil >= object.y) && (self.collision_box.y.ceil >= object.y + object.height)
          objects << {object: object, side: 'top'}
        elsif (self.collision_box.x > object.x) && (self.collision_box.x + self.collision_box.width > object.x + object.width)
          objects << {object: object, side: 'left'}
        elsif (self.collision_box.x < object.x) && (self.collision_box.x + self.collision_box.width < object.x + object.width)
          objects << {object: object, side: 'right'} 
        end
      end
    end

    return objects.empty? ? false : objects
  end

end