extends Node
class_name ObjectPooling

signal objectPollingSetWithSucessfuly(config)

onready var dataGroups = $data

export(Dictionary) var configPooling
export(bool) var configOnStart = true

var controllerObjects:Dictionary

func getObjectsByGroup(group:String) -> Array:
	return controllerObjects[group]

func spaw(config:Dictionary, data:Dictionary = {}) -> Array:
	var counter = 0
	var objectsManagersSpaw = []
	
	for object in controllerObjects[config["group"]]:
		if config.has("count"):
			if counter == config["count"]:
				break
		else: config["count"] = 1
		
		if not object.getActive():
			var data_object = data
			if config.has("metafunction"):
				var metafunction:FuncRef = config["metafunction"]["function"]
				data_object = metafunction.call_funcv(config["metafunction"]["args"])
			var object_spaw = object._spaw(data_object)
			objectsManagersSpaw.append(object_spaw)
			counter += 1
	
	return objectsManagersSpaw

func reset(group:String):
	var objects = getObjectsByGroup(group)
	for object in objects:
		if object.getActive():
			object._reset()

func makeGroupsByConfig(config:Dictionary):
	configPooling = config
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
			objectManager._reset()

func _ready():
	if configOnStart:
		makeGroupsByConfig(configPooling)
