extends Node

onready var spawner = $spawner

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_1:
					spawner.get_node("ManagerComponets").getComponet(45).stop()
					print("Stop spawner")
				KEY_2:
					spawner.get_node("ManagerComponets").getComponet(45).resume()
					print("Resume spawner")
				KEY_0:
					spawner.init()
					print("Init spawner")

func _on_controller_functions_functionsInit(controller:ControllerFunctions):
	pass
