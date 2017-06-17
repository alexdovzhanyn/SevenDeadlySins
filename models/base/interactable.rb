class Interactable < Rectangle
	include Observable

	attr_reader :collision_box

	def initialize(opts={})
		super(opts)

		@collision_box = opts[:collision_box] || nil
		@defined_action = opts[:interact_action]
	end

	def action
		changed
		@defined_action.call(self)
		notify_observers(true)
	end

	def reposition_with_collision_box(collision_box)
		self.x = collision_box.x + collision_box.width/2 - self.width / 2
		self.y = collision_box.y
	end

end