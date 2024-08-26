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
		var hurtBox = entity.get_
		if !hurtBox.is_connected("hurtNoValue", self, "generateFragments"):
			hurtBox.connect("hurtNoValue", self, "generateFragments")

func generateFragments(meteor):
		
	var managerComponet = meteor.get_node("ManagerComponets")
		
	var meteorControl = managerComponet.getComponet(45)
		
	var meteorHeight = meteorControl.getCurrentData().height
	var meteorCount = meteorControl.getCurrentData().fragments
	print(meteorControl.getCurrentData())
	var fragments = meteorControl.getFragmets(meteorHeight, meteorControl.getCurrentData().fragments)
	for fragment in get_meta("fragments"):
		var obj = objectPooling.spaw({ "group": "meteors" }, {
			"meteor_data": fragment,
			"fragment": "",
			"position": meteor.global_position,
			"motion_config": load("res://nodes/motion_engine/meta/data/fragments.tres")
		})
