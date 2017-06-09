class Platform < Collidable
	attr_accessor :sprite

	def initialize(opts={})
		super(opts)

		if opts[:sprite]
			@sprite = Image.new({x: opts[:x], y: opts[:y], z: opts[:z], path: opts[:sprite]})

			# sprite.width = opts[:width]
			@sprite.height = opts[:height]
		end
	end

end