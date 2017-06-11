class FinishBlock < Collidable

	def initialize(opts={})
		opts[:x] = units_to_pixels(opts[:x])
		opts[:y] = units_to_pixels(opts[:y])
		opts[:width] = units_to_pixels(opts[:width])
		opts[:height] = units_to_pixels(opts[:height])
		opts[:prevent_collision] = true

		if opts[:sprite]
			@sprite = Image.new({x: opts[:x], y: opts[:y], z: opts[:z], path: opts[:sprite]})

			@sprite.width = units_to_pixels(@sprite.width)
			@sprite.height = units_to_pixels(@sprite.height)
			@sprite.z = opts[:z]
		end

		super(opts)
	end

end