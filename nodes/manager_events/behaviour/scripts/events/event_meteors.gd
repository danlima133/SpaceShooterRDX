extends Event

export(Array, NodePath) var spawnersRefs

onready var spawner = $spawner
onready var duration = $duration

func _setSpawnersActive(value:bool):
	for spawnerRef in spawnersRefs:
		var spawner = get_node(spawnerRef)
		var managerComponets = spawner.get_node("ManagerComponets") as ManagerComponets
		match value:
			false:
				managerComponets.getComponet(45).stop()
			true:
				managerComponets.getComponet(45).resume()

func _start():
	_setSpawnersActive(false)
	spawner.init()
	duration.start()

func _eventFinished():
	var runner = spawner.get_node("ManagerComponets").getComponet(45)
	runner.stop()
	duration.stop()
	_setSpawnersActive(true)

func _on_duration_timeout():
	eventFinished()
