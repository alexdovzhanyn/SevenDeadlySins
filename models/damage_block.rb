class DamageBlock < Platform
	
	attr_accessor :damage

	def initialize(opts={})
		super(opts)

		@damage = opts[:damage]
	end

end