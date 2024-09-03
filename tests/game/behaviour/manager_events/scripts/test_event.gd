extends Event

onready var eventTimer = $eventTimer

var lastTimeEvent:float

func _config():
	print(getEventName() + " config")

func _start():
	print("event test start")
	eventTimer.start()

func _update(delta):
	print("event test update")

func _stop():
	lastTimeEvent = eventTimer.time_left
	eventTimer.stop()

func _resume():
	eventTimer.start(lastTimeEvent)

func _on_eventTimer_timeout():
	eventFinished()
