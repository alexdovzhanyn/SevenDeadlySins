class ChestSlot < InterfaceRectangle
	attr_accessor :item, :icon

	def initialize(opts={})
		@item = opts[:item]
		if @item
			icon_opts = opts.clone
			icon_opts[:path] = @item.icon
			[:color, :width, :height].each{|value| icon_opts.delete(value)}
			icon_opts[:z] += 5
			@icon = InterfaceImage.new(icon_opts)
			@icon.width = units_to_pixels(@icon.width)
			@icon.height = units_to_pixels(@icon.height)
		end

		super(opts)
	end

end