class InterfaceRectangle < Rectangle
	attr_accessor :fixed_position, :has_mouseover_function, :mouseover, :mouseleave, :moused_over

	def initialize(opts={})
		@moused_over = false
		@fixed_position = opts[:fixed_position]
		@has_mouseover_function = !opts[:mouseover].nil?
		@mouseover = opts[:mouseover]
		@mouseleave = opts[:mouseleave]
		
		super(opts)
	end
end