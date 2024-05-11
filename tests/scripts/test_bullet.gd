extends Node2D

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_R:
			get_tree().reload_current_scene()
