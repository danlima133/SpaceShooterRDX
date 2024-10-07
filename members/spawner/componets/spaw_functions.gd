extends Componet

const dynamicResources = preload("res://libs/resource_dynamic.lib.gd")

onready var spawnConfig = $"../.."

func _on_func_const_step(value, function, metadado):
	var _countToSpaw = spawnConfig.getConfig().getValue("countToSpaw") as Array
	var _valueMin = dynamicResources.getValueFromRand(_countToSpaw, dynamicResources.Value.MIN)
	var _valueMax = dynamicResources.getValueFromRand(_countToSpaw, dynamicResources.Value.MAX)
	var _newValue:Array
	if dynamicResources.isRangeValue(_countToSpaw):
		_newValue = dynamicResources.createNewRand(_valueMin + value, _valueMax + value)
	else:
		_newValue = dynamicResources.createNewRand(_valueMin + value)
	spawnConfig.getConfig().setValue("countToSpaw", _newValue)


func _on_func_variation_step(value, function, metadado):
	var _countToSpaw = spawnConfig.getConfig().getValue("countToSpaw") as Array
	var _newRand:Array = dynamicResources.createNewRand(int(value/2), value)
	spawnConfig.getConfig().setValue("countToSpaw", _newRand)

func _on_controller_functions_startFunction(function:Function):
	print(function.getFunctionName())
	print(function.getFunctionData()._data)
