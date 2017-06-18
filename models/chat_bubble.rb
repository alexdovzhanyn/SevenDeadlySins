class ChatBubble < Image
	attr_accessor :timeout

	def initialize(opts={})
		opts[:path] = './assets/interface/chat_bubble.png'
		super(opts)

		@timeout = opts[:timeout]
		self.width = units_to_pixels(self.width)
		self.height = units_to_pixels(self.height)
		self.y = self.y - self.height

		@text = GameText.new({
			x: self.x + 20,
			y: self.y + 5,
			z: self.z + 1,
			font: GAME_FONT,
			color: [0,0,0,1],
			text: opts[:text],
			size: 10
		})


	end

	def remove_self
		@text.remove
		self.remove
	end
end