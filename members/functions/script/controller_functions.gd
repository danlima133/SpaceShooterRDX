extends Node
class_name ControllerFunctions

signal functionsInit(controller)
signal stopFunction(function)
signal resumeFunction(function)
signal startFunction(function)
signal restartFunction(function)
signal changeFunction(function)

onready var deley = $deley
onready var functions = $functions

var _lastDeley:float

var _currentFunction

func _on_deley_timeout():
	if getCurrentFunction()._count == -1:
		getCurrentFunction()._lastDeley = 0
	else:
		getCurrentFunction()._lastDeley += getCurrentFunction().getDeley()
	getCurrentFunction()._count += 1
	getCurrentFunction()._action()
	getCurrentFunction().step()

func setFunctionData(functionName:String, dataPath:String):
	if isFunctionValid(functionName):
		var function:Function = getFunction(functionName)
		function.setDataPath(dataPath)
	else:
		return ERR_INVALID_PARAMETER

func configFunctions():
	for function in functions.get_children():
		function._config(function.getDataPath(), function.getHead())
	emit_signal("functionsInit", self)

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
