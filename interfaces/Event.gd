extends Node
class_name Event

signal eventStart(event)
signal eventFinished(event)

export(String) var _eventName

var _currentManager

func _config():
	pass

func _start():
	pass

func _update(delta):
	pass

func _stop():
	pass

func _resume():
	pass

func eventFinished():
	emit_signal("eventFinished", self)

func getEventName() -> String:
	return _eventName

func getManager():
	return _currentManager

func setEventName(value):
	_eventName = value
