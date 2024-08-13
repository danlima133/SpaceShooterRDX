extends Componet

signal spaw(entity)

const dynamicResource = preload("res://libs/resource_dynamic.lib.gd")

onready var spawnerTimer = $spawnerTimer
onready var spawConfig = $"../.."

onready var object_pooling = $"../../object_pooling"

var lastTimer:float

var controllerFunctions:ControllerFunctions

func run():
	randomize()
	_setTimer()
	
	controllerFunctions.start()
	
	spawConfig.getConfig().resetResource()

func _on_spawnerTimer_timeout():
	_preCalc()

func _setTimer():
	var timer:float
	
	if dynamicResource.isRangeValue(spawConfig.getConfig().getValue("timeSpaw")):
		timer = dynamicResource.generateRangeValue(spawConfig.getConfig().getValue("timeSpaw"), dynamicResource.TypeRand.FLOAT)
	else:
		timer = dynamicResource.getValueFromRand(spawConfig.getConfig().getValue("timeSpaw"), dynamicResource.Value.DEFAULT)
	
	spawnerTimer.wait_time = timer
	spawnerTimer.start()

func _on_ManagerComponets_MangerComponetsInitialize(componetsInit, manager:ManagerComponets):
	controllerFunctions = manager.getComponet(874)

func _preCalc():
	var count:int
	var position = currentManager.get_parent().positionSpaw.global_position
	
	if dynamicResource.isRangeValue(spawConfig.getConfig().getValue("countToSpaw")):
		count = dynamicResource.generateRangeValue(spawConfig.getConfig().getValue("countToSpaw"), dynamicResource.TypeRand.INT)
	else:
		count = dynamicResource.getValueFromRand(spawConfig.getConfig().getValue("countToSpaw"), dynamicResource.Value.DEFAULT)
	
	for index in range(count):
		_spaw()
	
	_setTimer()

func _spaw():
	var position:Vector2
	
	var entityPosition:Dictionary
	entityPosition = spawConfig.getConfig().getValue("entityPosition")
	
	var positionXRand:bool
	var positionYRand:bool
	
	positionXRand = dynamicResource.isRangeValue(entityPosition["x"])
	positionYRand = dynamicResource.isRangeValue(entityPosition["y"])
	
	if positionXRand:
		position.x += dynamicResource.generateRangeValue(entityPosition["x"], dynamicResource.TypeRand.FLOAT)
	if positionYRand:
		position.y += dynamicResource.generateRangeValue(entityPosition["y"], dynamicResource.TypeRand.FLOAT)
	
	if not (positionXRand and positionYRand):
		position += Vector2(dynamicResource.getValueFromRand(entityPosition["x"], dynamicResource.Value.DEFAULT), dynamicResource.getValueFromRand(entityPosition["y"], dynamicResource.Value.DEFAULT))
		
	var entities = object_pooling.spaw({ "group": "entities" }, {
		"position": position + currentManager.get_parent().positionSpaw.global_position
	})
	
	emit_signal("spaw", entities)

func stop():
	lastTimer = spawnerTimer.time_left
	spawnerTimer.stop()
	controllerFunctions.stop()

func resume():
	spawnerTimer.start(lastTimer)
	controllerFunctions.resume()

func clearSpawner():
	object_pooling.reset("entities")
