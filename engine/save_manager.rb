class SaveManager

	def self.load(save)
		file = File.open(save, 'r')
		return Marshal::load(file)
		file.close
	end

	def self.find_existing_saves
		return Dir['./saves/*']
	end

	def self.save
		file = File.open('./saves/save_1', 'w+')

		save_hash = {
			player: {
				health: $player.health,
				name: $player.name,
				x: $player.collision_box.x,
				y: $player.collision_box.y + $player.collision_box.height,
				z: $player.collision_box.z,
				velocityY: $player.collision_box.velocityY,
				inventory: {
					items: Marshal::dump($player.inventory.items)
				}
			},
			level: {
				distance_from_origin_x: $level.x,
				distance_from_origin_y: $level.y,
				interactable_objects: {
					chests: Application.get(:window).objects.select{|obj| obj.kind_of? Chest}.map{|chest| {"#{chest.id}": Marshal::dump(chest.items)}}.reduce({}, :merge)
				}
			}
		}
		file.write(Marshal::dump(save_hash))
		file.close
	end

end