# Unmutable - always returns a new vector
class Vector
	constructor: (@x, @y) ->

	copy: ->
		new Vector @x, @y

	# addition
	apply: (vector) ->
		new Vector @x + vector.x, @y + vector.y

	length: ->
		Math.sqrt( @x * @x + @y * @y )

	# angle in deg [0, 360[
	angle: ->
		deg = Math.atan2(@y, @x) * 180 / Math.PI
		if deg < 0
			deg = 360 + deg
		return deg

	# same angle, length 1
	unit: ->
		length = @length()
		if length is 0
			return new Vector 0, 0

		new Vector @x / length, @y / length

	setLength: (length) ->
		unit = @unit()
		new Vector unit.x * length, unit.y * length

	# sets the angle to the closest 90deg angle. returns 90/270deg in case of a 45deg input
	straighten: ->
		v = @copy()
		if Math.abs(v.x) < Math.abs(v.y)
			v.x = 0
		else
			v.y = 0
		return v

	rotate: (deg) ->
		v = new Vector
		rad = deg * Math.PI / 180
		v.x = @x * Math.cos(rad) - @y * Math.sin(rad)
		v.y = @x * Math.sin(rad) + @y * Math.cos(rad)
		return v

	invert: ->
		new Vector -@x, -@y

	# looks up significant axis on input, sets this axis to 0 on this vector
	eliminateAxis: (vector) ->
		vector = vector.straighten()
		if vector.x != 0
			return new Vector 0, @y
		else if vector.y != 0
			return new Vector @x, 0
		return @