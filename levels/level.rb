class Level
	attr_accessor :x, :y, :width

	def initialize(objects)
		puts "Initializing level..."
		lowest_x = 0
		highest_x = 0

		# Calculate width of the level.
		# Width is equal to the distance between the x position of the object with the lowest x position in the level
		# and the x position plus the width of the object with the highest x position in the level.
		# This will need to be updated for calculating the height of the level in the future
		objects.each do |object|
			if object.respond_to?(:tiles)
				object.tiles.each do |tile|
					if tile.collision_box.x < lowest_x
						lowest_x = tile.collision_box.x
					elsif tile.collision_box.x + tile.collision_box.width > highest_x
						highest_x = tile.collision_box.x + tile.collision_box.width
					end
				end
			else
				if object.x < lowest_x
					lowest_x = object.x
				elsif object.x + object.width > highest_x
					highest_x = object.x + object.width
				end
			end
		end

		@x = 0
		@y = 0
		@width = lowest_x.abs + highest_x.abs

		puts "Level width: #{@width}"
	end

end