extends Node
class_name ObjectPooling

signal objectPollingSetWithSucessfuly(config)

onready var dataGroups = $data

export(Dictionary) var configPooling

var controllerObjects:Dictionary

func getObjectsByGroup(group:String) -> Array:
	return controllerObjects[group]

func spaw(config:Dictionary, data:Dictionary = {}) -> Array:
	var counter = 0
	var objectsManagersSpaw = []
	
	for object in controllerObjects[config["group"]]:
		if object.getActive() == false:
			objectsManagersSpaw.append(object._spaw(data))
			counter += 1
			
			if config.has("count"):
				if counter == config["count"]:
					break
			else: break
	
	return objectsManagersSpaw

func makeGroupsByConfig(config:Dictionary):
	var groups = configPooling.keys()
	for group in groups:
		var node = Node2D.new()
		node.name = group
		dataGroups.add_child(node, true)
	_makeObjectsByConfig()
	emit_signal("objectPollingSetWithSucessfuly", config)

func _makeObjectsByConfig():
	var groups = configPooling.keys()
	for group in groups:
		var config = configPooling[group]
		var groupNode = dataGroups.get_node(group)
		
		controllerObjects[group] = []
		
		for index in range(config["count"]):
			var object = load(config["object"]).instance()
			var objectManager:ObjectManager
			
			if object.has_node("ObjectManager"):
				objectManager = object.get_node("ObjectManager")
				objectManager._setGroup(group)
				var isOk = objectManager._initObject()
				if isOk:
					objectManager._objectEnter()
			
			controllerObjects[group].append(objectManager)
			groupNode.add_child(object)

func _ready():
	makeGroupsByConfig(configPooling)
