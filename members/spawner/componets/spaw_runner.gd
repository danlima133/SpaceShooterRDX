extends Componet

signal spaw(entity)

const dynamicResource = preload("res://libs/resource_dynamic.lib.gd")

onready var spawnerTimer = $spawnerTimer
onready var spawConfig = $"../.."

onready var object_pooling = $"../../object_pooling"

var lastTimer:float
var lastPositionSpaw:Vector2

func run():
	randomize()
	_setTimer()
	if spawConfig.getConfig().getValue("useFunction"):
		var function = spawConfig.getConfig().callMethod("getFunctionAsString", [spawConfig.getConfig().getValue("typeFunction")])
		spawConfig.controllerFunctions.start(function)
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

func _getPositionWithTolerace(testPosition:Vector2, tolerance:int, offset:float) -> Vector2:
	var newPosition:Vector2
	var distance = lastPositionSpaw.distance_to(testPosition)
	if distance <= tolerance:
		var dir = (testPosition - lastPositionSpaw).normalized() / 2
		var correctionPos = dir * (tolerance + offset)
		var diference = lastPositionSpaw - (testPosition + correctionPos)
		return diference
	return Vector2.ZERO

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

	var pos = _getPositionWithTolerace(position, spawConfig.tolerance, spawConfig.offset)
	if pos != Vector2.ZERO:
		if position.x != 0:
			position.x = pos.x
		if position.y != 0:
			position.y = pos.y
	
	var entities = object_pooling.spaw({ "group": "entities" }, {
		"position": position + currentManager.get_parent().positionSpaw.global_position
	})
	
	emit_signal("spaw", entities)

func stop():
	lastTimer = spawnerTimer.time_left
	spawnerTimer.stop()
	spawConfig.controllerFunctions.stop()

func resume():
	spawnerTimer.start(lastTimer)
	spawConfig.controllerFunctions.resume()

func clearSpawner():
	object_pooling.reset("entities")
