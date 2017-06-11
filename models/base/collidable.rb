class Collidable < Rectangle

	attr_accessor :prevent_collision

	def initialize(opts={})
		super(opts)

		@prevent_collision = opts[:prevent_collision] || false
	end

end