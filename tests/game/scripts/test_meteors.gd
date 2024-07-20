extends Node2D

onready var meteor = $meteor
onready var fragaments = $fragaments

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_0:
					meteor.get_node("ManagerComponets").getComponet(45).setMeteor()
				KEY_F:
					for index in fragaments.get_child_count():
						randomize()
						var m = fragaments.get_child(index)
						m.get_node("ManagerComponets").getComponet(45).setMeteor({
							"image": load("res://assets/sprites/meteors/grey/fragaments/low/%s.png" % (randi() % 3)),
							"resistence": 1,
							"damage": 1
						})
						m.global_position.x = m.global_position.x + (index * 40)
