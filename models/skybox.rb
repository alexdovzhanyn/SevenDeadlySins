class Skybox < Image
	attr_accessor :fixed_position

	def initialize(opts={})
		super(opts)

		@fixed_position = true
	end

end