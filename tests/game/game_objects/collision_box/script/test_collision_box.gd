extends Node

onready var hit_box = $hit_box
onready var hurt_box = $hurt_box

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			print_debug()
			match event.scancode:
				KEY_A:
					hit_box.setActive(true, { "all": true })
					hurt_box.setActive(true, { "all": true })
				KEY_D:
					hit_box.setActive(false, { "all": true })
					hurt_box.setActive(false, { "all": true })
