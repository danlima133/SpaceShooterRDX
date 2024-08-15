extends Node

const dynamicResources = preload("res://libs/resource_dynamic.lib.gd")

onready var objectPooling = $object_pooling
onready var controllerFunctions = $controller_functions

export(Resource) var _spawData
export(Dictionary) var configPooling = {
	"entities": {
		"count": 0,
		"object": ""
	}
}
export(NodePath) var positionSpawPath
export(bool) var initActive = true

var positionSpaw:Position2D

var spawRunner:Componet

func _on_ManagerComponets_MangerComponetsInitialize(componetsInit, manager:ManagerComponets):
	spawRunner = manager.getComponet(45)

func _on_func_const_step(value, function, metadado):
	var _countToSpaw = _spawData.getValue("countToSpaw") as Array
	var _valueMin = dynamicResources.getValueFromRand(_countToSpaw, dynamicResources.Value.MIN)
	var _valueMax = dynamicResources.getValueFromRand(_countToSpaw, dynamicResources.Value.MAX)
	var _newValue:Array
	if dynamicResources.isRangeValue(_countToSpaw):
		_newValue = dynamicResources.createNewRand(_valueMin + value, _valueMax + value)
	else:
		_newValue = dynamicResources.createNewRand(_valueMin + value)
	_spawData.setValue("countToSpaw", _newValue)
	print(_spawData.getValue("countToSpaw"), _newValue)

func _ready():
	positionSpaw = get_node(positionSpawPath)
	if _spawData != null:
		_configSpaw()
	else:
		printerr("Erro: no SpawData in %s" % self)

func _configSpaw():
	var resourceDynamic = dynamicResources.ResourceDynamic.new(_spawData, false)
	_spawData = resourceDynamic
	objectPooling.makeGroupsByConfig(configPooling)
	controllerFunctions.configFunctions()
	controllerFunctions.setFunctionData("constValue", _spawData.getValue("functionData"))
	if initActive:
		spawRunner.run()

func init():
	spawRunner.run()

func getConfig() -> SpawData:
	return _spawData
