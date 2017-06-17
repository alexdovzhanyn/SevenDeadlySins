class Npc < Humanoid
	attr_accessor :destination, :idle_timer

	def initialize(opts={}, &block)
		super(opts)

		@destination = nil
		@interactable = Interactable.new({
			x: self.collision_box.x,
			y: self.collision_box.y,
			height: self.collision_box.height,
			width: self.collision_box.width * 3,
			interact_action: opts[:interact_action] || ->(context){puts "No action defined."},
			collision_box: self.collision_box,
			color: [0,0,0,0]
		})

		self.collision_box.add_observer(@interactable, :reposition_with_collision_box)
		@interactable.add_observer(self, :interacted)
		@idle_timer = 0
	end	

	# Generate a destination within 50 units of where NPC is standing,
	# 1% chance of movement per frame, so about 60% chance of movement every second
	def generate_destination
		if rand(0...100) == 1
			directions = [1, -1]
			# Destination is just an invisible marker that gets updated alongside the camera
			@destination = Rectangle.new({
				x: ( self.collision_box.x + (rand(units_to_pixels(20)...units_to_pixels(200)) * directions[rand(0..1)]) ), 
				y: (self.collision_box.y + self.collision_box.height),
				width: units_to_pixels(3),
				height: units_to_pixels(3),
				color: [0,0,0,0]
			})
		end
	end

	def clear_destination
		if self.destination
			self.destination.remove
			return self.destination = nil
		end
	end

	# Walk to destination unless we've reached it
	def walk_to_destination
		if self.collision_box.x >= self.destination.x - 2 && self.collision_box.x <= self.destination.x + 2
			return self.clear_destination
		end

		if self.calculate_destination_direction != 0 && self.can_move(calculate_destination_direction)
			# Initialize a copy of self to see if we will be on the platform by walking to this destination
			temp_self_right = self.clone
			temp_self_left = self.clone
			temp_self_right.collision_box = self.collision_box.clone
			temp_self_left.collision_box = self.collision_box.clone
			temp_self_right.collision_box.x += temp_self_right.collision_box.width
			temp_self_left.collision_box.x -= temp_self_left.collision_box.width
			temp_self_right.collision_box.x -= (temp_self_right.collision_box.x <=> self.destination.x) * 2
			temp_self_left.collision_box.x -= (temp_self_left.collision_box.x <=> self.destination.x) * 2
			
			
			# Make sure entity doesnt fall off edge by walking this way
			if !temp_self_right.can_move(:down) && !temp_self_left.can_move(:down)
				self.collision_box.x -= (self.collision_box.x <=> self.destination.x) * 2
			else
				# Move entity back a bit so that when we next generate their temp, it doesnt automatically fall down
				self.collision_box.x -= (self.collision_box.x <=> self.destination.x) * -2
				return self.clear_destination
			end
		else
			return self.clear_destination
		end
	end

	def calculate_destination_direction
		case self.collision_box.x <=> self.destination.x
			when 1
				return :left
			when -1
				return :right
			else
				return 
		end	
	end

	def interacted(opts)
		self.clear_destination
		self.idle_timer = 120
	end

end