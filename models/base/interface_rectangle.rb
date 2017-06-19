class InterfaceRectangle < Rectangle
	attr_accessor :fixed_position, :has_mouseover_function, :mouseover, :mouseleave, :mouseclick, :moused_over

	def initialize(opts={})
		@moused_over = false
		@fixed_position = opts[:fixed_position]
		@has_mouseover_function = !opts[:mouseover].nil?
		@mouseover = opts[:mouseover]
		@mouseleave = opts[:mouseleave]
		@mouseclick = opts[:mouseclick]
		
		super(opts)
	end
end