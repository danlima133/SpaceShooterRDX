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
				KEY_F:
					controllerFunctions.start("constValue")
				KEY_9:
					controllerFunctions.restart(true)

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

func _on_func_const_toLimit(function:Function):
	var graphFunction = function.getFunctionGraph()
	print(graphFunction.getValueBaseBYAxis(graphFunction.Axis.X, graphFunction.Base.END))
	print(graphFunction.getValueBaseBYAxis(graphFunction.Axis.Y, graphFunction.Base.START))
	print("point | for X = 12: %s" % graphFunction.getPoint(12.0))
	print("Axis X = " + str(graphFunction.getDataByAxis(graphFunction.Axis.X)))
	print("Axis Y = " + str(graphFunction.getDataByAxis(graphFunction.Axis.Y)))
