class Sword < Weapon
	attr_accessor :name

	def initialize(opts={})
		super(opts)
		@name = opts[:name]
	end

end