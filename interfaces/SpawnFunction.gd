extends Node
class_name Function

signal toLimit()
signal step(value, function, metadado)

export(String) var _functionName
export(Dictionary) var _functionData

export(Array) var headData

var _functionsController

var _deley:float = 0
var _limit:int = 0
var _stepValue:int = 0

var _count:int = -1

var _data:Dictionary
var _lastDeley:float = 0

var _functionDataObject:FunctionData

var metaDado:Dictionary

class FunctionData:
	var _data:Dictionary
	
	func _init(data:Dictionary):
		_data = data
	
	func getValue(valueName:String):
		if _data.has(valueName):
			return _data[valueName]
		else: return ERR_INVALID_PARAMETER
	
	func hasValue(valueName:String) -> bool:
		return _data.has(valueName)
	
	func getTargetData() -> Dictionary:
		return _data

func _config(data:Dictionary, head:Array):
	name = _functionName
	_functionData = data
	_functionsController = $"../.."
	if not head.empty():
		_deley = head[0]
		_limit = head[1]
		_stepValue = head[2]

func _start():
	pass

func _action():
	pass

func step():
	if not getLimit() == getCountActions():
		print(_lastDeley)
		_data[_lastDeley + getDeley()] = getStepValue()
		getFunctionsController().deley.wait_time = getDeley()
		getFunctionsController().deley.start()
		emit_signal("step", getStepValue(), getFunctionName(), metaDado)
		metaDado = {}
	else:
		resetCount()
		emit_signal("toLimit")

func getFunctionData() -> FunctionData:
	if _functionDataObject == null:
		return FunctionData.new(_functionData)
	return _functionDataObject

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
	_count = -1

func getCountActions() -> int:
	return _count
