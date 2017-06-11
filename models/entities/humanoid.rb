class Humanoid
	attr_accessor :collision_box, :sprite

	def initialize(opts={})
		opts[:x] = units_to_pixels(opts[:x])
		opts[:y] = units_to_pixels(opts[:y])

		@name = opts[:name]

		@sprite = Image.new({x: opts[:x], y: opts[:y], z: opts[:z], path: opts[:sprite]})
		@sprite.width = units_to_pixels(@sprite.width)
		@sprite.height = units_to_pixels(@sprite.height)
		@sprite.z = opts[:z]

		@collision_box = Rectangle.new({x: opts[:x], y: opts[:y], z: opts[:z], width: @sprite.width, height: @sprite.height, color: [0,0,0,0]})

		@name_text = GameText.new({x: @sprite.x, y: @sprite.y - 50, z: @sprite.z, text: @name, color: 'white', font: './assets/fonts/Ubuntu-B.ttf'})
		@name_text.x = (@sprite.x + @sprite.width/2) - @name_text.width/2
	end

end