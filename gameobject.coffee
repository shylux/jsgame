# Base for all objects appearing on the screen or interacting with it
class GameObject extends Rect
	color: "Black"

	constructor: (@dimensions = new Vector(0, 0),
				  @position = new Vector(0, 0),
				  @velocity = new Vector(0, 0),
				  @gravity = new Vector(0, 0)) ->
		@ctx = Game.ctx
		Game.gameObjects.push @

	draw: ->
		@ctx.fillStyle = @color
		@ctx.rect @position.x, @position.y, @dimensions.x, @dimensions.y
		@ctx.fill()

	applyGravity: ->
		@velocity = @velocity.apply @gravity
		@position = @position.apply @velocity

	# applies an effect on the other object (does not change this object)
	handleCollision: (gobj) ->
		return

	# 1 arg: GameObject, 2 args: x and y coordinates
	doesCollide: (args...) ->

		if args.length is 1
			rect = args[0]
			# we don't collide with ourself
			if @ is rect
				return

		else if args.length is 2
			rect = new Rect( new Vector(args[0], args[1]), new Vector(0, 0))

		# detection copied from https://developer.mozilla.org/en-US/docs/Games/Techniques/2D_collision_detection
		(@left() < rect.right() &&
	 	 @right() > rect.left() &&
		 @top() < rect.bottom() &&
		 @bottom() > rect.top())

	# returns size of overlapping area of 2 rects
	# if this object crashes in the other object from the left/top side, the values are negative
	diff: (gobj) ->
		width = Math.min(@right(), gobj.right()) - Math.max(@left(), gobj.left())
		# if my center is to the right of the other center: invert my diff value
		if ( @left()+(@right() - @left())/2 > gobj.left()+(gobj.right() - gobj.left())/2 )
			width *= -1
		height = Math.min(@bottom(), gobj.bottom()) - Math.max(@top(), gobj.top())
		if ( @top()+(@bottom() - @top())/2 > gobj.top()+(gobj.bottom() - gobj.top())/2 )
			height *= -1

		new Vector width, height

	# check if the object touches environment in the given direction
	# bothd: check in the given direction and the opposite direction
	hasContact: (direction, bothd = false) ->
		checkpoints = []
		# down
		if direction.y > 0 or direction.y != 0 and bothd
			checkpoints.push new Vector( @left(), @bottom() + 1)
			checkpoints.push new Vector( @right(), @bottom() + 1)
		if direction.y < 0 or direction.y != 0 and bothd
			checkpoints.push new Vector( @left(), @top() - 1)
			checkpoints.push new Vector( @right(), @top() - 1)
		if direction.x > 0 or direction.x != 0 and bothd
			checkpoints.push new Vector( @right() + 1, @top())
			checkpoints.push new Vector( @right() + 1, @bottom())
		if direction.x < 0 or direction.x != 0 and bothd
			checkpoints.push new Vector( @left() - 1, @top())
			checkpoints.push new Vector( @left() - 1, @bottom())
				

		for env in Game.gameObjects when env instanceof FixEnvironment
			for checkpoint in checkpoints
				if env.doesCollide checkpoint.x, checkpoint.y
					return true

		return false

