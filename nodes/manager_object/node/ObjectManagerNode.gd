extends Node
class_name ObjectManager, "res://nodes/manager_object/icon/node.png"

signal activeObject(data)
signal desactiveObject(data)
signal objectInit

export var objectProcess:NodePath

var _group:String
var _active:bool

var _objectProcess:ObjectProcess

func _initObject():
	if !objectProcess.is_empty():
		_objectProcess = get_node(objectProcess)
		_objectProcess._objectManager = self
		_objectProcess._objectRoot = get_parent()
		_objectProcess.emit_signal("objectProcessInit")
		return true
	return false

func getObjectProcess():
	return _objectProcess

func _setActive(value):
	_active = value

func getActive():
	return _active

func _setGroup(group):
	_group = group

func getGroup():
	return _group

func _spaw(data:Dictionary = {}) -> ObjectManager:
	_setActive(true)
	_objectProcess._spaw(data)
	emit_signal("activeObject", data)
	return self

func _objectEnter():
	_setActive(false)
	_objectProcess._objectEnter()
	emit_signal("objectInit")

func _reset(data:Dictionary = {}) -> ObjectManager:
	_setActive(false)
	_objectProcess._reset(data)
	emit_signal("desactiveObject", data)
	return self

