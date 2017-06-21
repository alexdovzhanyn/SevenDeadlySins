class GameMenu
	attr_accessor :open
	
	def initialize
		@open = false

		@buttons = [
			{
				text: 'BACK TO GAME',
				toggle: -> () {
					self.toggle
				}
			},
			{
				text: 'SAVE GAME',
				toggle: -> () {
					SaveManager.save
					self.toggle
				}
			},
			{
				text: 'EXIT GAME',
				toggle: -> () {
					Application.close
				}
			}
		]
	end

	def toggle
		if self.open
			self.open = false
			$interface_controller.remove_item(self)
		else
			self.open = true

			@background = InterfaceRectangle.new({
				x: 0,
				y: 0,
				z: 100000,
				width: units_to_pixels(WINDOW_WIDTH),
				height: units_to_pixels(WINDOW_HEIGHT),
				color: [0,0,0,0.5],
				fixed_position: true
			})

			@visual_elements = []

			button_offset = 0
			@buttons.each_with_index do |button, i|
				rectangle =  InterfaceRectangle.new({
					x: units_to_pixels(WINDOW_WIDTH)/2 - 150,
					y: 100 + button_offset,
					z: 1000001,
					width: 300,
					height: 50,
					color: [1,1,1,1],
					fixed_position: true,
					mouseclick: button[:toggle],
					mouseover: ->() {
						@visual_elements.select{|element| element.kind_of? InterfaceRectangle}[i].color = 'gray'
					},
					mouseleave: ->() {
						@visual_elements.select{|element| element.kind_of? InterfaceRectangle}[i].color = [1,1,1,1]
					}
				})

				text = GameText.new({
					x: rectangle.x,
					y: rectangle.y,
					z: 1000002,
					color: 'black',
					font: GAME_FONT,
					text: button[:text],
					size: 30
				})

				text.x += rectangle.width/2 - text.width/2
				text.y += rectangle.height/2 - text.height/2

				@visual_elements << rectangle
				@visual_elements << text

				button_offset += 75
			end

			$interface_controller.add_item(self)
		end
	end

	def remove_visuals
		self.open = false
		@background.remove
		@visual_elements.each(&:remove)
	end

end