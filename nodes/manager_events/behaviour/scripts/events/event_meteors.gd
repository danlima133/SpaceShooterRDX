extends Event

onready var spawner = $spawner
onready var duration = $duration

func _start():
	spawner.init()
	duration.start()

func _eventFinished():
	var runner = spawner.get_node("ManagerComponets").getComponet(45)
	runner.stop()
	duration.stop()

func _on_duration_timeout():
	eventFinished()
