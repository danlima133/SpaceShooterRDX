extends Node
class_name ControllerFunctions

signal functionsInit()
signal stopFunction(function)
signal resumeFunction(function)
signal startFunction(function)
signal restartFunction(function)

onready var deley = $deley
onready var functions = $functions

export(String) var function

var _lastDeley:float

var _currentFunction

func _ready():
	_configFunctions()
	if isFunctionValid(function):
		start(function)

func _configFunctions():
	for function in functions.get_children():
		function._config(function.getFunctionData(), function.getHead())
	emit_signal("functionsInit")

func _on_deley_timeout():
	getCurrentFunction()._count += 1
	getCurrentFunction()._action()
	getCurrentFunction().step()

func start(functionName:String):
	_currentFunction = getFunction(functionName)
	_currentFunction._start()
	deley.start()
	emit_signal("startFunction", getCurrentFunction().getFunctionName())

func stop():
	_lastDeley = deley.time_left
	deley.stop()
	emit_signal("stopFunction", getCurrentFunction().getFunctionName())

func resume():
	deley.start(_lastDeley)
	emit_signal("resumeFunction", getCurrentFunction().getFunctionName())

func restart(full:bool):
	if hasFunction():
		_currentFunction._start()
		deley.start()
		if full:
			_currentFunction._count = 0
		emit_signal("restartFunction", getCurrentFunction().getFunctionName())

func getFunction(functionName:String):
	if isFunctionValid(functionName):
		return functions.get_node(functionName)
	return ERR_INVALID_PARAMETER

func getCurrentFunction():
	return _currentFunction

func hasFunction() -> bool:
	return true if _currentFunction != null else false

func isFunctionValid(functionName:String) -> bool:
	return true if functions.has_node(functionName) else false
