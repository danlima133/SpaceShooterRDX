extends Componet

signal grow(factor)

onready var spawnerConfig = $"../.."
onready var deley = $deley

var _counts:int
var _lastTime:float

func _init_componet():
	if spawnerConfig.getConfig().useFunction:
		if spawnerConfig.initActive:
			_start()
	
func _on_deley_timeout():
	_counts += 1
	
	if _counts == spawnerConfig.getConfig().functionData["limit"]:
		deley.stop()
		return
	
	emit_signal("grow", spawnerConfig.getConfig().functionData["factor"])
	
	deley.start()

func _start():
	randomize()
	deley.wait_time = spawnerConfig.getConfig().functionData["deley"]
	deley.start()

func _stopFunction():
	_lastTime = deley.time_left
	deley.stop()

func _resumeFunction():
	deley.start(_lastTime)
