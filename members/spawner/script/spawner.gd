extends Node

const dynamicResources = preload("res://libs/resource_dynamic.lib.gd")

onready var objectPooling = $object_pooling

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
	if initActive:
		spawRunner.run()

func init():
	spawRunner.run()

func getConfig() -> SpawData:
	return _spawData
