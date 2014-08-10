class Rect
	
	constructor: (@position = new Vector
				  @dimensions = new Vector)->

	width: ->
		@dimensions.x

	height: ->
		@dimensions.y

	top: ->
		@position.y
	right: ->
		@position.x + @dimensions.x
	bottom: ->
		@position.y + @dimensions.y
	left: ->
		@position.x
