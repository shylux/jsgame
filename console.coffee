# Input class to make state exchange easier
class Console
	up: false
	right: false
	down: false
	left: false

	refresh: ->
		keys = KeyboardJS.activeKeys()
		@up = "up" in keys
		@right = "right" in keys
		@down = "down" in keys
		@left = "left" in keys
