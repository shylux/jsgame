class Player extends GameObject
	@runAccel = 1
	@maxRunSpeed = 5

	@jumpAccelUp = 5
	@jumpAccelWall = 5

	constructor: (@name
		          position = new Vector 20, 20
		          gravity = new Vector 0, 0.1) ->
		super
		@dimensions = new Vector 20, 20
		@position = position
		@gravity = gravity

		@console = new Console
		Game.players.push @
		console.log "New Player", @name

	handleInput: ->
		# walkvector according to players gravity
		walkVector = new Vector 0, 0
		@console.refresh()
		if @console.right and not @console.left
			walkVector.x = 1
		if @console.left and not @console.right
			walkVector.x = -1
		walkVector = walkVector.rotate @gravity.angle() - 90
		walkVector.setLength(Player.runAccel)

		# check if the player can run this fast
		walkVector = walkVector.apply @velocity
		if walkVector.eliminateAxis(@gravity).length() < Player.maxRunSpeed
			@velocity = walkVector

		# jump!
		# check ground contact
		if @console.up and @hasContact @gravity
			@velocity = @velocity.apply @gravity.straighten().invert().setLength Player.jumpAccelUp

		# walljump
		# only possible when grinding on wall
		else if @console.up and \
				@velocity.straighten().angle() is @gravity.angle() and \ # only when going down the wall
				@hasContact @velocity.eliminateAxis(@gravity), true
			jumpUp = @gravity.invert().setLength(Player.jumpAccelUp)
			jumpSide = @velocity.eliminateAxis(@gravity).invert().setLength(Player.jumpAccelWall)
			@velocity = jumpUp.apply jumpSide

	draw: ->
		super
		@ctx.fillText JSON.stringify(@console), 40, 40