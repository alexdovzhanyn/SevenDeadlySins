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
			Chest.new({
				x: units_to_pixels(10),
				y: units_to_pixels(WINDOW_HEIGHT - BASE_HEIGHT*2 - 9),
				z: 0,
				items: [
					Sword.new({
						name: 'Rusty Dagger',
						damage: 0.5,
						icon: './assets/interface/icons/weapons/rusty_sword.png'
					})
				]
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
			Collidable.new({
				x: units_to_pixels(320), 
				y: units_to_pixels(80), 
				z: 0, 
				height: units_to_pixels(70), 
				width: units_to_pixels(20), 
				color: [0,0,0,1]
			}),
			Collidable.new({
				x: units_to_pixels(320), 
				y: units_to_pixels(-20), 
				z: 0, 
				height: units_to_pixels(50), 
				width: units_to_pixels(20), 
				color: [0,0,0,1]
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

		$entities.concat([
			Npc.new({
				name: 'Aurelion',
				x: 120,
				y: WINDOW_HEIGHT - BASE_HEIGHT - 20,
				z: 1,
				path: './assets/sprites/aurelion.png',
				interact_action: ->(context){ 
					ChatBubble.new({
						x: context.collision_box ? context.collision_box.x + context.collision_box.width : context.x + context.width/2, 
						y: context.collision_box ? context.collision_box.y + 25 : context.y, 
						z: context.collision_box ? context.collision_box.z : context.z, 
						timeout: 120,
						text: "Hey there, buddy"
					})
				},
			})
		])

		@spawn_point = {
			x: 100,
			y: WINDOW_HEIGHT - BASE_HEIGHT - 20
		}

		super(@constant_objects)
	end
end