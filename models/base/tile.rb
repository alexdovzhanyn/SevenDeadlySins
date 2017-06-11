class Tile
	attr_accessor :collision_box, :sprite

	def initialize(opts={})
		@sprite = Image.new({x: opts[:x], y: opts[:y], z: opts[:z], path: opts[:path]})
		@sprite.width = units_to_pixels(@sprite.width)
		@sprite.height = units_to_pixels(@sprite.height)
		@sprite.z = opts[:z]


		@collision_box = Collidable.new({x: opts[:x], y: opts[:y], z: opts[:z], width: @sprite.width, height: @sprite.height, color: [0,0,0,0]})
	end

end