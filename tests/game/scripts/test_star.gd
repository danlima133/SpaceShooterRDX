extends Node2D

const RegularMath = preload("res://libs/regular_math.lib.gd")

onready var object_pooling = $object_pooling

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_0:
					object_pooling.spaw({ "group": "stars", "count": 3}, {
						"position": Vector2(1280/2, 720/2)
					})
#					var map = RegularMath.RectsMap.Map.new({
#						"size": {
#							"x": 5,
#							"y": 5
#						},
#						"cellSize": 30,
#						"origin": Vector2(1280/2, 720/2),
#						"offset": Vector2(-75, -75),
#						"debug": true
#					}, self)
#
#					var algorithm = RandomNumberGenerator.new()
#					algorithm.randomize()
#					var controller = RegularMath.RectsMap.new(map, algorithm)
#
#					var positions = controller.getPositionsByCount(3)
#
#					for position in positions:
#						var cell = map.getRectByPosition(position)
#						object_pooling.spaw({ "group": "stars" }, {
#						"position": Vector2(1280/2, 720/2),
#						"positionTarget": cell.get_center()
#					})
