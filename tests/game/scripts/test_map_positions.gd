extends Node2D

const RegularMath = preload("res://libs/regular_math.lib.gd")

const textures = [
	preload("res://assets/sprites/enemies/enemyBlack1.png"),
	preload("res://assets/sprites/enemies/enemyBlack4.png"),
	preload("res://assets/sprites/enemies/enemyRed2.png"),
	preload("res://assets/sprites/enemies/enemyBlue4.png")
	]

onready var camera_2d = $content/Camera2D

var velocityCamera:Vector2

func _ready():
	var map = RegularMath.RectsMap.Map.new({
		"size": {
			"x": 21,
			"y": 1
		},
		"cellSize": 120,
		"origin": global_position,
		"offset": Vector2(-2520-20, 0),
		"id": "map",
		"debug": false
	}, $content)
	#get_node("content").add_child(map)

	var algorithm = RandomNumberGenerator.new()
	algorithm.randomize()
	var controller = RegularMath.RectsMap.new(map, algorithm)
	var positions = controller.getPositionsByCount(5)
	for pos in positions:
		var sprite = Sprite.new()
		var texture = textures[algorithm.randi() % textures.size()]
		sprite.texture = texture
		var r = map.getRectByPosition(pos)
		sprite.global_position = r.get_center()
		get_node("content").add_child(sprite)

func _process(delta):
	if Input.is_action_just_pressed("player_shoot"):
		if has_node("content/map"):
			var map = get_node("content/map")
			map.debugActive(!map.isDebug())
	
	if Input.is_action_pressed("player_right"):
		velocityCamera = Vector2.RIGHT
	elif Input.is_action_pressed("player_left"):
		velocityCamera = Vector2.LEFT
	else:
		velocityCamera = Vector2.ZERO

	camera_2d.translate(velocityCamera * 350 * delta)
