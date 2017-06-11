class GameText < Text
	attr_accessor :fixed_position

	def initialize(opts={})
		super(opts)

		@fixed_position = opts[:fixed_position]
	end

end