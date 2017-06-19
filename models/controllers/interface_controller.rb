class InterfaceController
	attr_accessor :open_interface_items
	
	def initialize(opts={})
		@open_interface_items = []
	end

	def add_item(item)
		if item.kind_of? Chest
			self.open_interface_items.select{|item| item.kind_of? Chest}.each do |item|
				self.remove_item(item)
			end

			self.open_interface_items.select{|item| item.kind_of? Player::Inventory}.first do |inventory|
				inventory.x += 300
			end
		end
		@open_interface_items << item
	end

	def remove_item(item)
		item.remove_visuals
		if item.kind_of? Chest
			self.open_interface_items.select{|item| item.kind_of? Player::Inventory}.first do |inventory|
				inventory.x -= 300
			end
		end

		@open_interface_items.delete(item)
	end
end