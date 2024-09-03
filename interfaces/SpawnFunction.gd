extends Node
class_name Function

signal toLimit(function)
signal step(value, function, metadado)

export(String) var _functionName
export(String, FILE, "*.functiondata") var _functionDataPath

export(Array) var headData
export(bool) var isLoop

onready var gameReadRule = $"../../readGameRule"

var _functionsController

var _deley:float = 0
var _limit:int = 0
var _stepValue:int = 0

var _count:int = -1

var _data:Dictionary
var _lastDeley:float = 0

var _functionDataObject:FunctionData
var _functionGraphObject:GraphData

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

class GraphData:
	enum Axis {
		X
		Y
	}
	
	enum Base {
		END
		START
	}
	
	var _data:Dictionary
	
	func _init(data):
		_data = data
	
	func getDataByAxis(axis):
		match axis:
			Axis.X:
				return _data.keys()
			Axis.Y:
				return _data.values()
		return ERR_INVALID_PARAMETER
	
	func getValueBaseBYAxis(axis, base) -> float:
		var _data = getDataByAxis(axis)
		var _value:float
		match base:
			Base.END:
				_value = _data[_data.size() - 1] 
			Base.START:
				_value = _data[0]
		return _value
	
	func getPoint(value):
		if _data.keys().has(value):
			return Vector2(value, _data[value])
		return ERR_DOES_NOT_EXIST

func _config(dataPath:String, head:Array):
	name = _functionName
	_functionsController = $"../.."
	setDataPath(dataPath)
	if not head.empty():
		_deley = head[0]
		_limit = head[1]
		_stepValue = head[2]

func _setStep():
	_data[_lastDeley + getDeley()] = getStepValue()
	_setDeleyTimer()
	emit_signal("step", getStepValue(), self, metaDado)

func _clearGraph():
	_data = {}
	_functionGraphObject = null

func _setDeleyTimer():
	getFunctionsController().deley.wait_time = getDeley()
	getFunctionsController().deley.start()

func _start():
	pass

func _action():
	pass

func step():
	match isLoop:
		false:
			if getCountActions() != getLimit():
				_setStep()
			else:
				resetCount()
				emit_signal("toLimit", self)
		true:
			_setStep()
	metaDado.clear()

func getFunctionData() -> FunctionData:
	return _functionDataObject

func getFunctionGraph() -> GraphData:
	if _functionGraphObject == null:
		return GraphData.new(_data)
	return _functionGraphObject

func getDataPath() -> String:
	return _functionDataPath

func setDataPath(path:String):
	var parser = $"../..".get_node("readGameRule")
	var rule = parser.RuleJson._read(path)
	if rule.err != OK:
		printerr("Data Path Invalid to %s" % self)
		return ERR_FILE_BAD_PATH
	_functionDataObject = FunctionData.new(rule.content)

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
