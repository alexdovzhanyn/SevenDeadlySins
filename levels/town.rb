class Town < Level
	attr_accessor :constant_objects, :spawn_point

	def initialize
		@constant_objects = [
			Platform.new({x: 0, y: (WINDOW_HEIGHT - BASE_HEIGHT), z: 0, height: BASE_HEIGHT, width: 1000, color: '#008000'}),
			Platform.new({x: 300, y: 400, z: 0, height: BASE_HEIGHT, width: 200, color: '#008000'}),
			Platform.new({x: 800, y: 250, z: 0, height: BASE_HEIGHT, width: 200, color: '#008000'}),
			Platform.new({x: 1400, y: 250, z: 0, height: BASE_HEIGHT, width: 300, color: '#008000'}),
			Platform.new({x: 2100, y: 500, z: 0, height: 100, width: 600, color: '#008000'}),
			DamageBlock.new({x: 1000, y: WINDOW_HEIGHT + 100, z: 0, height: BASE_HEIGHT, width: 1100, color: [0,0,0,0], damage: 1000}),
			FinishBlock.new({x: 2300, y: 320, z: 0, height: 180, width: 130, color: '#8B4513'})
		]

		@spawn_point = {
			x: 200,
			y: (WINDOW_HEIGHT - BASE_HEIGHT)
		}

		super(@constant_objects)
	end
end