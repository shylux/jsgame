# For platforms, borders etc. Pushes the player away so he can stand on it.
class FixEnvironment extends GameObject

	handleCollision: (gobj) ->
		if gobj instanceof Player
			diff = gobj.diff @
			if Math.abs(diff.x) < Math.abs(diff.y)
				gobj.position.x -= diff.x
				gobj.velocity.x = 0
			else
				gobj.position.y -= diff.y
				gobj.velocity.y = 0
