class Item
	attr_accessor :icon
	
	def initialize(opts={})
		@icon = opts[:icon]
	end

end