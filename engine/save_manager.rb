class SaveManager

	def self.load(save)
		file = File.open(save, 'r')
		return Marshal::load(file)
	end

	def self.find_existing_saves
		return Dir['./saves/*']
	end

	def self.save
		binding.pry
		file = File.open('./saves/save_1', 'w+')

		save_hash = {
			player: {
				health: $player.health,
				name: $player.name,
				x: $player.collision_box.x,
				y: $player.collision_box.y - $player.collision_box.height,
				z: $player.collision_box.z,
				velocityY: $player.collision_box.velocityY,
				inventory: {
					items: Marshal::dump($player.inventory.items)
				}
			},
			# level: {
			# 	constant_objects: $level.constant_objects.map{|object| }
			# }
		}
		file.write(Marshal::dump(save_hash))
	end

end