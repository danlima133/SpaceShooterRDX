extends Node
class_name Event

signal eventStart(event)
signal eventFinished(event)

export(String) var _eventName
export(bool) var _eventCanPaused = true

var _currentManager
var _stop

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

func _eventFinished():
	pass

func eventFinished():
	_eventFinished()
	emit_signal("eventFinished", self)

func getEventName() -> String:
	return _eventName

func getManager():
	return _currentManager

func setEventName(value):
	_eventName = value

func isStop() -> bool:
	return _stop

func setStop(value:bool):
	_stop = value
