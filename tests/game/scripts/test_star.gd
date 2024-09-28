extends Node2D

const RegularMath = preload("res://libs/regular_math.lib.gd")

onready var object_pooling = $object_pooling

var __dynamic_posibilities = RegularMath.Radom.DynamicPosibilities.new()

func _ready():
	var random_input = RegularMath.Radom.DynamicPosibilities.RandomInput.new()
	
	random_input.set_input({
		"percent_base": RegularMath.percent_to_decimal(5),
		"percent_bonus": RegularMath.percent_to_decimal(2),
		"percent_fall": RegularMath.percent_to_decimal(4),
		"height_succsse": 6,
		"height_fall": 3
	})
	
	__dynamic_posibilities.set_random_input(random_input)
	__dynamic_posibilities.randomize()

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_0:
					var counts = __dynamic_posibilities.get_count_with_posibility(3)
					print(counts)
					object_pooling.spaw({ "group": "stars", "count": counts}, {
						"position": Vector2(1280/2, 720/2)
					})
