extends Node
class_name ObjectProcess

signal objectProcessInit

var _objectManager
var _objectRoot

func getObjectManger():
	return _objectManager

func getObjetcRoot():
	return _objectRoot

func _spaw(data:Dictionary = {}):
	pass

func _process_on_spaw(delta):
	pass

func _objectEnter():
	pass

func _reset(data:Dictionary = {}):
	getObjetcRoot().global_position = data["position"]
	
