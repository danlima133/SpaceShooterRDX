extends Node

onready var objectPooling = $object_pooling

export(NodePath) var spawnerPath

var spawner:Object

func _ready():
	spawner = get_node(spawnerPath)
	
	var spawRunner = spawner.get_node("ManagerComponets").getComponet(45)
	spawRunner.connect("spaw", self, "_spawnerToSpaw")

func _componetsInit(componetInit, manager:ManagerComponets):
	var spawRunner = manager.getComponet(45)
	spawRunner.connect("spaw", self, "_spawnerToSpaw")

func _spawnerToSpaw(entity):
	if entity.size() != 0:
		var object = entity[0].getObjectProcess().getObjetcRoot()
		
		var hurtBox = object.get_node("hurt_box")
		var managerComponet = object.get_node("ManagerComponets")
		
		var meteorControl = managerComponet.getComponet(45)
		
		var meteorHeight = meteorControl.getCurrentData()["data"]["height"]
		var meteorCount = meteorControl.getCurrentData()["data"]["fragments"]
		
		var fragments = meteorControl.getFragmets(meteorHeight, meteorCount, meteorControl.getCurrentData()["color"])
		
		set_meta("fragments", fragments)
		
		if !hurtBox.is_connected("hurtNoValue", self, "generateFragments"):
			hurtBox.connect("hurtNoValue", self, "generateFragments")

func generateFragments(hurtBox):
	for fragment in get_meta("fragments"):
		var obj = objectPooling.spaw({ "group": "meteors" }, {
			"meteor_data": fragment,
			"fragment": "",
			"position": hurtBox.global_position,
			"motion_config": load("res://nodes/motion_engine/meta/data/fragments.tres")
		})
