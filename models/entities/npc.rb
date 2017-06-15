class Npc < Humanoid
	attr_accessor :destination

	def initialize(opts={})
		super(opts)

		@destination = nil
	end	

	# Generate a destination within 50 units of where NPC is standing
	def generate_destination
		@destination = self.collision_box.x + rand(units_to_pixels(-50)...units_to_pixels(50))
		puts @destination
	end

	# Walk to destination unless we've reached it
	def walk_to_destination
		if self.collision_box.x <= self.destination + 1 && self.collision_box.x >= self.destination - 1
			return self.destination = nil
		end

		self.collision_box.x -= (self.collision_box.x <=> self.destination) * 2
	end

end