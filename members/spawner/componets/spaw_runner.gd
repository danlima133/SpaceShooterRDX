extends Componet

onready var spawnerTimer = $spawnerTimer
onready var spawConfig = $"../.."

onready var object_pooling = $"../../object_pooling"

var lastTimer:float

func run():
	randomize()
	_setTimer()
	
func _on_spawnerTimer_timeout():
	_preCalc()

func _setTimer():
	var timer:float
	
	if spawConfig.timeIsRandom:
		var timeMin = spawConfig.getConfig().timeSpaw[0]
		var timeMax = spawConfig.getConfig().timeSpaw[1]
		timer = rand_range(timeMin, timeMax)
	else:
		timer = spawConfig.getConfig().timeSpaw[0]
	
	spawnerTimer.wait_time = timer
	spawnerTimer.start()
	
	print("Spawner timer: %s" % timer)

func _preCalc():
	var count:int
	var position = currentManager.get_parent().positionSpaw.global_position
	
	if spawConfig.countIsRandom:
		var countMin = spawConfig.getConfig().countToSpaw[0]
		var countMax = spawConfig.getConfig().countToSpaw[1]
		count = round(rand_range(countMin, countMax))
	else:
		count = spawConfig.getConfig().countToSpaw[0]
	
	for index in range(count):
		_spaw()
	
	_setTimer()
	
	print("Spawner count at spaw: %s" % count)

func _spaw():
	var position:Vector2
	
	if spawConfig.positionsRandom["x"]:
		position.x += rand_range(spawConfig.getConfig().entityPosition["x"][0], spawConfig.getConfig().entityPosition["x"][1])
	if spawConfig.positionsRandom["y"]:
		position.y += rand_range(spawConfig.getConfig().entityPosition["y"][0], spawConfig.getConfig().entityPosition["y"][1])
	
	if not (spawConfig.positionsRandom["x"] and spawConfig.positionsRandom["y"]):
		position += Vector2(spawConfig.getConfig().entityPosition["x"][0], spawConfig.getConfig().entityPosition["y"][0])
		
	object_pooling.spaw({ "group": "entities" }, {
		"position": position + currentManager.get_parent().positionSpaw.global_position
	})

func stop():
	lastTimer = spawnerTimer.time_left
	spawnerTimer.stop()

func resume():
	spawnerTimer.start(lastTimer)

func clearSpawner():
	object_pooling.reset("entities")
