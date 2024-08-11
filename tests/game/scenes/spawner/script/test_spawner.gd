extends Node

onready var spawner = $spawner

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_S:
					spawner.get_node("ManagerComponets").getComponet(45).stop()
					print("Stop spawner")
				KEY_R:
					spawner.get_node("ManagerComponets").getComponet(45).resume()
					print("Resume spawner")
