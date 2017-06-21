class GameMouse < Rectangle
	attr_accessor :attached_item, :attached_icon

	def initialize(opts={})
		super(opts)

		@attached_item = opts[:attached_item] || nil
		@attached_icon = @attached_item ? @attached_item.icon : nil
	end

	def attached_item=(item)
		if @attached_item
			@attached_icon.remove
		end

		@attached_item = item

		if @attached_item
			@attached_icon = InterfaceImage.new({
				x: self.x,
				y: self.y,
				z: 101,
				path: @attached_item.icon
			})
			@attached_icon.width = units_to_pixels(@attached_icon.width)
			@attached_icon.height = units_to_pixels(@attached_icon.height)
		else
			@attached_icon.remove
			@attached_icon = nil
		end
	end

	def x=(x)
		@x = x

		if self.attached_item
			self.attached_icon.x = x
		end
	end

	def y=(y)
		@y = y

		if self.attached_item
			self.attached_icon.y = y
		end
	end
end