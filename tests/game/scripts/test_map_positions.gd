extends Node2D

const RegularMath = preload("res://libs/regular_math.lib.gd")

const textures = [
	preload("res://assets/sprites/enemies/enemyBlack1.png"),
	preload("res://assets/sprites/enemies/enemyBlack4.png"),
	preload("res://assets/sprites/enemies/enemyRed2.png"),
	preload("res://assets/sprites/enemies/enemyBlue4.png")
	]

func _ready():
	var map = RegularMath.RectsMap.Map.new({
		"size": {
			"x": 10,
			"y": 1
		},
		"cellSize": 125,
		"origin": Vector2(10.24, 0),
		"debug": true
	})
	add_child(map)

	var algorithm = RandomNumberGenerator.new()
	algorithm.randomize()
	var controller = RegularMath.RectsMap.new(map, algorithm)
	var positions = controller.getPositionsByCount(2)
	for pos in positions:
		var sprite = Sprite.new()
		var texture = textures[algorithm.randi() % textures.size()]
		sprite.texture = texture
		var r = map.getRectByPosition(pos)
		sprite.global_position = r.get_center()
		add_child(sprite)
