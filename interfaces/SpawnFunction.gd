extends Node
class_name Function

signal toLimit()
signal step(value, function, metadado)

export(String) var _functionName
export(Dictionary) var _functionData

export(Array) var headData

var _functionsController

var _deley:float
var _limit:int
var _stepValue:int

var _count:int

var metaDado:Dictionary

func _config(data:Dictionary, head:Array):
	name = _functionName
	_functionData = data
	_deley = head[0]
	_limit = head[1]
	_stepValue = head[2]
	_functionsController = $"../.."

func _start():
	pass

func _action():
	pass

func step():
	if not getLimit() == getCountActions():
		getFunctionsController().deley.wait_time = getDeley()
		getFunctionsController().deley.start()
		emit_signal("step", getStepValue(), getFunctionName(), metaDado)
		metaDado = {}
	else:
		resetCount()
		emit_signal("toLimit")

func getFunctionData() -> Dictionary:
	return _functionData

func getHead() -> Array:
	return headData

func getFunctionName() -> String:
	return _functionName

func getFunctionsController():
	return _functionsController

func getDeley() -> float:
	return _deley

func setDeley(value:float):
	_deley = value

func getLimit() -> int:
	return _limit

func setLimit(value:int):
	_limit = value

func getStepValue() -> int:
	return _stepValue

func setStepValue(value:int):
	_stepValue = value

func resetCount():
	_count = 0

func getCountActions() -> int:
	return _count
