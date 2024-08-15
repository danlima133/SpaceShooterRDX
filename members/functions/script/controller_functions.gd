extends Node
class_name ControllerFunctions

signal functionsInit()
signal stopFunction(function)
signal resumeFunction(function)
signal startFunction(function)
signal restartFunction(function)
signal changeFunction(function)

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
		function._config(function.getFunctionData().getTargetData(), function.getHead())
	emit_signal("functionsInit")

func _on_deley_timeout():
	if getCurrentFunction()._count == -1:
		getCurrentFunction()._lastDeley = 0
	else:
		getCurrentFunction()._lastDeley += getCurrentFunction().getDeley()
	getCurrentFunction()._count += 1
	getCurrentFunction()._action()
	getCurrentFunction().step()

func start(functionName:String):
	if hasFunction():
		_currentFunction.resetCount()
		_currentFunction._clearGraph()
		emit_signal("changeFunction", getFunction(functionName))
	_currentFunction = getFunction(functionName)
	_currentFunction._start()
	_currentFunction._setDeleyTimer()
	emit_signal("startFunction", _currentFunction)

func stop():
	_lastDeley = deley.time_left
	deley.stop()
	emit_signal("stopFunction", _currentFunction)

func resume():
	deley.start(_lastDeley)
	emit_signal("resumeFunction", _currentFunction)

func restart(full:bool):
	if hasFunction():
		_currentFunction._start()
		deley.start()
		if full:
			_currentFunction.resetCount()
			_currentFunction._data.empty()
			_currentFunction._functionGraphObject = null
		emit_signal("restartFunction", _currentFunction)

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
