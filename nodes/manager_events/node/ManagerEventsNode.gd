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
		return OK
	return ERR_UNAVAILABLE

func stopEvent():
	if hasEvent():
		if canPaused(currentEvent):
			set_process(false)
			currentEvent._stop()
			currentEvent.setStop(true)
			emit_signal("eventStop", currentEvent)
			return OK
		return ERR_UNAUTHORIZED
	return ERR_UNAVAILABLE

func resumeEvent():
	if hasEvent():
		if currentEvent.isStop() and canPaused(currentEvent):
			set_process(true)
			currentEvent._resume()
			currentEvent.setStop(false)
			emit_signal("eventResume", currentEvent)
			return OK
		return ERR_UNAUTHORIZED
	return ERR_UNAVAILABLE

func getEvent(eventName:String) -> Event:
	return get_node(eventName) as Event

func getCurrentEvent() -> Event:
	return currentEvent

func canPaused(event:Event) -> bool:
	return event._eventCanPaused

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
