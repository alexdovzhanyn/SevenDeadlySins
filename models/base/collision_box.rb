class CollisionBox < Rectangle
	include Observable
	attr_accessor :velocityY

	def initialize(opts={})
		opts[:color] = [0,0,0,0]

		@velocityY = 0

		super(opts)
	end

	def x=(val)
		changed
		super(val)
		notify_observers(self)
	end

	def y=(val)
		changed
		super(val)
		notify_observers(self)
	end

	def velocityY=(val)
		changed
		@velocityY = val
		notify_observers(self)
	end
	
end