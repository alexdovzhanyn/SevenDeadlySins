class Chest < Collidable
	attr_accessor :items, :open

	def initialize(opts={})
		@open = false
		@items = opts[:items]
		@sprite = Image.new({
			x: opts[:x],
			y: opts[:y],
			z: opts[:z],
			path: opts[:sprite] || './assets/sprites/chest.png'
		})

		@sprite.width = units_to_pixels(@sprite.width)
		@sprite.height = units_to_pixels(@sprite.height)

		@interactable = Interactable.new({
			x: @sprite.x - @sprite.width/2,
			y: @sprite.y,
			z: @sprite.z - 1,
			width: @sprite.width * 2,
			height: @sprite.height,
			interact_action: -> (context) {
				self.toggle_interior
			},
			color: [0,0,0,0]
		})


		opts[:prevent_collision] = true
		super(opts)
	end

	def toggle_interior
		if self.open
			$interface_controller.remove_item(self)
		else
			self.open = true
			$interface_controller.add_item(self)

			@interior = InterfaceImage.new({x: 100, y: units_to_pixels(WINDOW_HEIGHT/2 - 92/2), z: 0, path: './assets/interface/container_interior.png'})
			@interior.width = units_to_pixels(@interior.width)
			@interior.height = units_to_pixels(@interior.height)
			@slots = []

			offset_x = 0
			offset_y = 0
			28.times do |i|
				if i > 0 && i % 7 == 0
					offset_x = 0
					offset_y += 11
				end

				@slots << ContainerSlot.new({
					x: @interior.x + units_to_pixels(3 + offset_x), 
					y: @interior.y + units_to_pixels(3 + offset_y), 
					z: @interior.z + 1, 
					width: units_to_pixels(9), 
					height: units_to_pixels(9),
					fixed_position: true,
					color: [0,0,0,0],
					item: self.items[i] ? self.items[i] : nil,
					mouseover: ->() {
						@slots[i].color = [1,1,1,0.2]
						if @slots[i].item && !@tooltip
							@tooltip = GameText.new({
								x: @slots[i].x + @slots[i].width + 10, 
								y: @slots[i].y, 
								z: @slots[i].z + 6,
								text: @slots[i].item.name,
								font: GAME_FONT,
								size: 12,
								fixed_position: true
							})
						end
					},
					mouseleave: ->() {
						@slots[i].color = [0,0,0,0]
						if @tooltip
							@tooltip.remove
							@tooltip = nil
						end
					}, 
					mouseclick: ->() {
						if @slots[i].item
							self.items.delete_at(i)

							if $mouse.attached_item
								temp_item = $mouse.attached_item
								self.items[i] = temp_item

								puts "added item"
							end

							$mouse.attached_item = @slots[i].item
							@slots[i].item = temp_item || nil

							if @tooltip
								@tooltip.remove
							end
						elsif !@slots[i].item && $mouse.attached_item
							@slots[i].item = $mouse.attached_item
							self.items[i] = $mouse.attached_item

							$mouse.attached_item = nil
						end
					}
				})

				offset_x += 11
			end
		end
	end

	def remove_visuals
		self.open = false
		@interior.remove
		@slots.each do |slot|
			if slot.item
				slot.icon.remove
			end

			slot.remove
		end

		if @tooltip
			@tooltip.remove
			@tooltip = nil
		end
	end

end