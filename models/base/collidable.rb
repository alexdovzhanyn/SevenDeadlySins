class Collidable < Rectangle
	attr_accessor :prevent_collision

	def initialize(opts={})
		opts[:color] ||= [0,0,0,0]
		super(opts)

		@prevent_collision = opts[:prevent_collision] || false
	end

end