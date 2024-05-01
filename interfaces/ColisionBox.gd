extends Area2D
class_name CollisionBox

signal boxInit(box)

export(int) var id

var _active = true

func initCollisionBox(colisionBox:CollisionBox):
	connect("area_entered", colisionBox, "_collisionEnterBox")
	connect("area_exited", colisionBox, "_collisionExitBox")
	emit_signal("boxInit", colisionBox)

func setActive(value:bool, indexs = -1) -> Dictionary:
	_active = value
	var shapesChange = {}
	
	if indexs is int:
		if indexs == -1:
			indexs = get_child_count() - 1
	
	for index in indexs:
		var shape = get_child(index) as CollisionShape2D
		if !shape.disabled == value:
			continue
		shape.set_deferred("disabled", !value)
		shapesChange[index] = shape.disabled
	
	return shapesChange

func getActive() -> bool:
	return _active

func _collisionEnterBox(box):
	pass

func _collisionExitBox(box):
	pass
