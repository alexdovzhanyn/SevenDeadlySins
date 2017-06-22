class Platform
	attr_accessor :tiles

	def initialize(opts={})
		opts[:x] = units_to_pixels(opts[:x])
		opts[:y] = units_to_pixels(opts[:y])

		@tiles = []

		opts[:width].times do |count|
			@tiles << Tile.new({x: opts[:x] + (units_to_pixels(5) * count), y: opts[:y], z: opts[:z], path: "./assets/tiles/grass_top_#{rand(1..5)}.png"})
		end
	end

end