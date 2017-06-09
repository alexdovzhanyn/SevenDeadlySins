class Camera

	attr_accessor :x, :y, :width, :height
	
	def initialize(opts={})
		@x = opts[:x]
		@y = opts[:y]
		@width = opts[:width]
		@height = opts[:height]
	end

	def move(x, y, level)
		# Camera moving is really just shifting the level in the opposite direction of where you want to move the camera.
		# Currently this moves only the constant, non-moving objects within a level. 
		# We will need to adjust this later to account for entities which are spawned in after the level is initialized.
		level.constant_objects.each do |object|
			object.x += x
			object.y += y
		end

		level.x += x
		level.y += y
	end

	def should_move?(player)
		# Decides whether the camera should move to follow the player or not.
		# This is lower on the left side because we care less about visibility behind the player than ahead of them.
		# If the camera should move, it returns the direction in which it should move, otherwise we return false
		if player.x < self.x + 200
			return 'Left'
		elsif player.x + player.width > self.width - 500 
			return 'Right'
		end

		return false
	end

end