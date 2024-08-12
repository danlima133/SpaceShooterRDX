extends Node

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

var timeIsRandom:bool
var countIsRandom:bool

var positionsRandom = {
	"x": false,
	"y": false
}

func _on_ManagerComponets_MangerComponetsInitialize(componetsInit, manager:ManagerComponets):
	spawRunner = manager.getComponet(45)

func _ready():
	positionSpaw = get_node(positionSpawPath)
	if _spawData != null:
		_configSpaw()
	else:
		printerr("Erro: no SpawData in %s" % self)

func _configSpaw():
	
	if _spawData.timeSpaw.size() == 2:
		timeIsRandom = true
	if _spawData.countToSpaw.size() == 2:
		countIsRandom = true
	
	if _spawData.entityPosition["x"].size() == 2:
		positionsRandom["x"] = true
	if _spawData.entityPosition["y"].size() == 2:
		positionsRandom["y"] = true
	
	objectPooling.makeGroupsByConfig(configPooling)
	
	if initActive:
		spawRunner.run()

func init():
	spawRunner.run()

func getConfig() -> SpawData:
	return _spawData
