# Handles game setup and loops
class Game
	@gameObjects: []
	@players: []

	# screen is <canvas> element
	constructor: (@screenId) ->
		@screen = $(@screenId)

		Game.ctx = @screen[0].getContext "2d"
		Game.ctx.width = @screen.width()
		Game.ctx.height = @screen.height()

		@ctx = Game.ctx

		@stage = new Stage

		#new GameObject(new Vector(10, 10))

		@loop(@)
		setInterval (-> console.log("ping")), 1000

	# uses self because setTimeout passes global context
	loop: (self) ->
		console.log "rinse and.."
		self.applyInput()
		self.applyGravity()
		self.collisionHandling()
		self.redraw()
		setTimeout self.loop, 17, self

	redraw: ->
		@ctx.beginPath()
		@ctx.clearRect 0, 0, @ctx.width, @ctx.height
		gobj.draw() for gobj in Game.gameObjects

	applyInput: ->
		player.handleInput() for player in Game.players

	applyGravity: ->
		gobj.applyGravity() for gobj in Game.gameObjects

	collisionHandling: ->
		for gobj in Game.gameObjects
			gobj.handleCollision otherobj for otherobj in Game.gameObjects when gobj.doesCollide otherobj 
