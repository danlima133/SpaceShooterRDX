extends Area2D
class_name CollisionBox

export(int) var id

func initCollisionBox(colisionBox:CollisionBox):
	connect("area_entered", colisionBox, "_collisionEnterBox")
	connect("area_exited", colisionBox, "_collisionExitBox")

func _collisionEnterBox(box):
	pass

func _collisionExitBox(box):
	pass
