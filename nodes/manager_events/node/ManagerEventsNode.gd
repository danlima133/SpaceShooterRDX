extends Node
class_name ManagerEvents, "res://nodes/manager_events/icon/node.png"

signal eventsConfigs(eventsInit)

signal eventStop(event)
signal eventResume(event)

var currentEvent:Event

func startEvent(eventName:String):
	if not hasEvent():
		var event = getEvent(eventName)
		currentEvent = event
		
		if not event.is_connected("eventFinished", self, "_eventFinished"):
			event.connect("eventFinished", self, "_eventFinished")
		
		event._start()
		set_process(true)
		
		event.emit_signal("eventStart", event)

func stopEvent():
	set_process(false)
	currentEvent._stop()
	emit_signal("eventStop", currentEvent)

func resumeEvent():
	set_process(true)
	currentEvent._resume()
	emit_signal("eventResume", currentEvent)

func getEvent(eventName:String) -> Event:
	return get_node(eventName) as Event

func getCurrentEvent() -> Event:
	return currentEvent

func hasEvent() -> bool:
	return (currentEvent != null)

func _ready():
	_setEvents()

func _process(delta):
	if hasEvent():
		currentEvent._update(delta)

func _setEvents():
	for event in get_children():
		event.name = event.getEventName()
		event._config()
	
	emit_signal("eventsConfigs", get_children().size())

func _eventFinished(event:Event):
	set_process(false)
	currentEvent = null
