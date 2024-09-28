extends Componet

signal spaw(entity)

const dynamicResource = preload("res://libs/resource_dynamic.lib.gd")
const RegularMath = preload("res://libs/regular_math.lib.gd")

onready var spawnerTimer = $spawnerTimer
onready var spawConfig = $"../.."

onready var object_pooling = $"../../object_pooling"

var lastTimer:float
var lastPositionSpaw:Vector2

var mapSpaw
var controllerMap

func run():
	var mapData = spawConfig.getConfig().getValue("mapData")
	print(mapData.get("offset", Vector2.ZERO))
	mapSpaw = RegularMath.RectsMap.Map.new({
		"size": {
			"x": mapData["x"],
			"y": mapData["y"]
		},
		"origin": spawConfig.positionSpaw.global_position,
		"offset": mapData["offset"],
		"cellSize": mapData["cell_size"],
		"debug": true
	})
	var root = currentManager.get_parent()
	root.add_child(mapSpaw)
	
	var algorithm = RandomNumberGenerator.new()
	algorithm.randomize()
	
	controllerMap = RegularMath.RectsMap.new(mapSpaw, algorithm)
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
	
	var positions = controllerMap.getPositionsByCount(count)
	
	for positionMap in positions:
		var rect = mapSpaw.getRectByPosition(positionMap)
		var entities = object_pooling.spaw({ "group": "entities", "count": 1 }, {
			"position": rect.get_center()
		})

		emit_signal("spaw", entities)
	
	_setTimer()

func stop():
	lastTimer = spawnerTimer.time_left
	spawnerTimer.stop()
	spawConfig.controllerFunctions.stop()

func resume():
	spawnerTimer.start(lastTimer)
	spawConfig.controllerFunctions.resume()

func clearSpawner():
	object_pooling.reset("entities")
