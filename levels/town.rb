class Town < Level
	attr_accessor :constant_objects, :spawn_point

	def initialize
		@constant_objects = [
			Platform.new({
				x: 0, 
				y: (WINDOW_HEIGHT - BASE_HEIGHT), 
				z: 0, 
				height: BASE_HEIGHT, 
				width: 40, 
				color: [0,0,0,0], 
				tile: './assets/tiles/grass_top.png'
			}),
			Platform.new({
				x: 60, 
				y: 100, 
				z: 0, 
				height: BASE_HEIGHT, 
				width: 8, 
				color: '#008000', 
				tile: './assets/tiles/grass_top.png'
			}),
			Platform.new({
				x: 160, 
				y: 70, 
				z: 0, 
				height: BASE_HEIGHT, 
				width: 8, 
				color: '#008000',
				tile: './assets/tiles/grass_top.png'
			}),
			Platform.new({
				x: 250, 
				y: 70, 
				z: 0, 
				height: BASE_HEIGHT, 
				width: 8, 
				color: '#008000',
				tile: './assets/tiles/grass_top.png'
			}),
			Platform.new({
				x: 420, 
				y: 120, 
				z: 0, 
				height: 8, 
				width: 24, 
				color: '#008000',
				tile: './assets/tiles/grass_top.png'
			}),
			DamageBlock.new({
				x: 200, 
				y: WINDOW_HEIGHT + 20, 
				z: 0, 
				height: BASE_HEIGHT, 
				width: 220, 
				color: [0,0,0,0], 
				damage: 1000
			}),
			FinishBlock.new({
				x: 460, 
				y: 86, 
				z: 0, 
				height: 35, 
				width: 24, 
				color: [0,0,0,0],
				sprite: './assets/sprites/wooden_door.png'
			})
		]

		@spawn_point = {
			x: units_to_pixels(100),
			y: units_to_pixels(WINDOW_HEIGHT - BASE_HEIGHT - 20)
		}

		super(@constant_objects)
	end
end