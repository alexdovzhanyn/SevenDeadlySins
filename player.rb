class Player < Rectangle
	MOVEMENT_SPEED = 10
	JUMP_SPEED = 10
	HEIGHT = 80
	WIDTH = 40
	
	attr_accessor :jumping

	def initialize(opts={})
		super(opts)

		jumping = false
	end

	def move_left
		self.x -= MOVEMENT_SPEED
	end

	def move_right
		self.x += MOVEMENT_SPEED
	end

	def toggle_jump
		self.jumping = true

		Thread.new do
			sleep 0.3
			self.jumping = false
		end
	end
end