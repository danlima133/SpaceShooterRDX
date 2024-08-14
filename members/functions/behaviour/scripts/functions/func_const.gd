extends Function

const dynamicResources = preload("res://libs/resource_dynamic.lib.gd")

var _intervalOffset:Array
var _intervalTime:Array
var _rateMax:int

func _start():
	_setData()
	
	setDeley(_getInterval(_intervalTime, dynamicResources.TypeRand.FLOAT))
	setLimit(_rateMax)

func _action():
	var _offset = _getInterval(_intervalOffset, dynamicResources.TypeRand.INT)
	setStepValue(getStepValue() + _offset)
	setDeley(_getInterval(_intervalTime, dynamicResources.TypeRand.FLOAT))
	metaDado = {
		"deley": getDeley(),
		"limit": getLimit(),
		"offset": _offset,
		"stepValue": getStepValue()
	}

func _getInterval(_interval:Array, typeRand:int):
	if dynamicResources.isRangeValue(_interval):
		return dynamicResources.generateRangeValue(_interval, typeRand)
	else:
		return dynamicResources.getValueFromRand(_interval, dynamicResources.Value.DEFAULT)

func _setData():
	if getFunctionData().hasValue("offset"):
		_intervalOffset = getFunctionData().getValue("offset")
	if getFunctionData().hasValue("deley"):
		_intervalTime = getFunctionData().getValue("deley")
	if getFunctionData().hasValue("limit"):
		_rateMax = getFunctionData().getValue("limit")
