# setup environment, spawn places etc.
class Stage
	
	constructor: (@name,
				  @dimensions = new Vector(1000, 600),
				  @backgroundColor = "Blue") ->
		@ctx = Game.ctx
		@setup()

	setup: ->
		# Borders
		new FixEnvironment(new Vector(@dimensions.x, 10))
		new FixEnvironment(new Vector(@dimensions.x, 10), new Vector(0, @dimensions.y-10))
		new FixEnvironment(new Vector(10, @dimensions.y))
		new FixEnvironment(new Vector(10, @dimensions.y), new Vector(@dimensions.x-10, 0))

		new FixEnvironment(new Vector(@dimensions.x-200, 20), new Vector(100, @dimensions.y/2-10))
		new FixEnvironment(new Vector(20, @dimensions.y-200), new Vector(@dimensions.x/2 - 10, 100))

		spawns = @getSpawnpoints()
		new Player "Player 1", spawns[0], new Vector(0, 0.1)
		new Player "Player 2", spawns[1], new Vector(-0.1, 0)
		new Player "Player 3", spawns[2], new Vector(0.1, 0)
		new Player "Player 4", spawns[3], new Vector(0, -0.1)

	getSpawnpoints: ->
		[
			new Vector 40, 40
			new Vector @dimensions.x - 60, 40
			new Vector 40, @dimensions.y - 60
			new Vector @dimensions.x - 60, @dimensions.y - 60
		]