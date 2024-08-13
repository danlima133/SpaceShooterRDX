extends Node

onready var controllerFunctions:ControllerFunctions = $controller_functions

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_0:
					controllerFunctions.restart(true)
				KEY_1:
					controllerFunctions.stop()
				KEY_2:
					controllerFunctions.resume()

func _on_controller_functions_resumeFunction(function):
	print("resume - %s" % function)

func _on_controller_functions_startFunction(function):
	print("start - %s" % function)

func _on_controller_functions_stopFunction(function):
	print("stop - %s" % function)

func _on_controller_functions_restartFunction(function):
	print("restart - %s" % function)

func _on_func_const_step(value, function, metadado):
	print(str(value) + " - " + function + " - " + str(metadado))
