class Weapon < Item
	attr_accessor :damage

	def initialize(opts={})
		@damage = opts[:damage]

		super(opts)
	end

end