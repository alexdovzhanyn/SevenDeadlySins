class Town < Level
	def initialize
		Platform.new({x: 0, y: (WINDOW_HEIGHT - BASE_HEIGHT), z: 0, height: BASE_HEIGHT, width: WINDOW_WIDTH, color: '#008000'})
		Platform.new({x: 300, y: 400, z: 0, height: BASE_HEIGHT, width: 200, color: '#008000'})
		Platform.new({x: 800, y: 250, z: 0, height: BASE_HEIGHT, width: 200, color: '#008000'})
		DamageBlock.new({x: 600, y: 450, z: 0, height: BASE_HEIGHT, width: 200, color: '#ff0000', damage: 0.5})
	end
end