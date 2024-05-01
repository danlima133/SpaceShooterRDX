extends Area2D
class_name CollisionBox

signal boxInit(box)
signal updateProperty(property, value, box)

export(int) var id

var _active = true

func initCollisionBox(colisionBox:CollisionBox):
	connect("area_entered", colisionBox, "_collisionEnterBox")
	connect("area_exited", colisionBox, "_collisionExitBox")
	emit_signal("boxInit", colisionBox)

func setActive(value:bool, config:Dictionary = {}):
	_active = value
	_setDicValuesDefault(config)
	
	match config.all:
		true:
			_controllerShapes(range(get_child_count()), value)
		false:
			_controllerShapes(config.shapeIdx, value)
	

func updateProperty(property:int, value, box:CollisionBox):
	emit_signal("updateProperty", property, value, box)

func getActive() -> bool:
	return _active

func _collisionEnterBox(box):
	pass

func _collisionExitBox(box):
	pass

func _controllerShapes(indexs:Array, value:bool):
	for index in indexs:
		var shape = get_child(index) as CollisionShape2D
		shape.set_deferred("disabled", !value)

func _setDicValuesDefault(dic):
	if !dic.has("all"):
		dic["all"] = true
	if !dic.has("shapeIdx"):
		dic["shapeIdx"] = []
