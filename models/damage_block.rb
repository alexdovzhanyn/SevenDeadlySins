class DamageBlock < Collidable
	
	attr_accessor :damage

	def initialize(opts={})
		opts[:x] = units_to_pixels(opts[:x])
		opts[:y] = units_to_pixels(opts[:y])
		opts[:width] = units_to_pixels(opts[:width])
		opts[:height] = units_to_pixels(opts[:height])

		super(opts)

		@damage = opts[:damage]
	end

end