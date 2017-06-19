class ContainerSlot < InterfaceRectangle
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

	def item=(item)
		temp_icon_values = self.icon || self
		@item = item

		if @item
			@icon = InterfaceImage.new({
				x: temp_icon_values.x,
				y: temp_icon_values.y,
				z: temp_icon_values.z,
				path: @item.icon
			})

			@icon.width = units_to_pixels(@icon.width)
			@icon.height = units_to_pixels(@icon.height)
		else
			self.icon.remove
			self.icon = nil
		end
	end

end