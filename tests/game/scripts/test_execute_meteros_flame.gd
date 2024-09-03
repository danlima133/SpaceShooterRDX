extends Node

onready var timer = $timer

export(NodePath) var managerEventsPath
export(float) var timeMin
export(float) var timeMax

var managerEvents:ManagerEvents

func _ready():
	if has_node(managerEventsPath):
		managerEvents = get_node(managerEventsPath)
	_setTimer()

func _executeMensage(mensage:String):
	print("TEST - execute meteors flame | %s \n" % mensage)

func _canExecute() -> bool:
	randomize()
	var factor = (randi() % 10 + 1)
	return (true if factor > 5 else false)

func _setTimer():
	randomize()
	
	var time = rand_range(timeMin, timeMax)
	timer.wait_time = time
	timer.start()
	
func _on_timer_timeout():
	_executeMensage("try execute")
	if _canExecute():
		managerEvents.startEvent("meteorsFlame")
		_executeMensage("execute")
		var event = managerEvents.getEvent("meteorsFlame")
		if not event.is_connected("eventFinished", self, "_eventFinished"):
			event.connect("eventFinished", self, "_eventFinished")
	else:
		_executeMensage("cancel execute")
		_setTimer()

func _eventFinished(event:Event):
	_executeMensage("end execute")
	_setTimer()
