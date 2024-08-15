extends Function

const dynamicResource = preload("res://libs/resource_dynamic.lib.gd")

var _variation:Array
var _pick:Dictionary

var _delta:int
var _nextTime:float

var _index:int

func _start():
	_index = 0
	
	_setData()
	setLimit(_variation.size())
	
	_setPick(_index)
	setDeley(_nextTime)

func _action():
	if _index == 0:
		setStepValue(_delta)
		setDeley(_nextTime)
	else:
		_setPick(_index)
		setStepValue(_delta)
		setDeley(_nextTime)
	_index += 1

func _setPick(index:int):
	if not index == getLimit():
		_pick = _variation[index]
		if dynamicResource.isRangeValue(_pick["delta"]):
			_delta = dynamicResource.generateRangeValue(_pick["delta"], dynamicResource.TypeRand.INT)
		else:
			_delta = dynamicResource.getValueFromRand(_pick["delta"], dynamicResource.Value.DEFAULT)
		
		if dynamicResource.isRangeValue(_pick["nextTime"]):
			_nextTime = dynamicResource.generateRangeValue(_pick["nextTime"], dynamicResource.TypeRand.FLOAT)
		else:
			_nextTime = dynamicResource.getValueFromRand(_pick["nextTime"], dynamicResource.Value.DEFAULT)

func _setData():
	if getFunctionData().hasValue("variation"):
		_variation = getFunctionData().getValue("variation")
