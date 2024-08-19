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
export(int) var tolerance
export(int) var offset
export(bool) var initActive = true

var positionSpaw:Position2D

var spawRunner:Componet

func _on_ManagerComponets_MangerComponetsInitialize(componetsInit, manager:ManagerComponets):
	spawRunner = manager.getComponet(45)

func _ready():
	positionSpaw = get_node(positionSpawPath)
	if _spawData != null:
		_configSpaw()
	else:
		printerr("Erro: SpawData in %s" % self)

func _configSpaw():
	var resourceDynamic = dynamicResources.ResourceDynamic.new(_spawData, false)
	_spawData = resourceDynamic
	objectPooling.makeGroupsByConfig(configPooling)
	if _spawData.getValue("useFunction"):
		controllerFunctions.configFunctions()
		controllerFunctions.setFunctionData(_spawData.callMethod("getFunctionAsString", [_spawData.getValue("typeFunction")]), _spawData.getValue("functionData"))
	_setSpawValue(_spawData.getValue("spawValues"))
	if initActive:
		spawRunner.run()

func _setSpawValue(data:Dictionary):
	var _tolerance = data["tolerance"]
	var _offset = data["offset"]
	if _tolerance != -1:
		tolerance = _tolerance
	
	if _offset != -1:
		offset = _offset

func init():
	spawRunner.run()

func getConfig() -> SpawData:
	return _spawData
