extends Node2D

onready var object_pooling = $object_pooling

var meteor

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_0:
					_makeMeteor()

func _makeMeteor():
	meteor = object_pooling.spaw({ "group": "test", "count": 1}, {
		"position": get_global_mouse_position()
		})[0]
	
	object_pooling.spaw({ "group": "test", "count": 1}, {
		"position": Vector2(rand_range(0, 1280), rand_range(0, 720))
	})

func _process(delta):
	if meteor != null:
		meteor.get_parent().global_position = get_global_mouse_position()
