extends RigidBody2D

var change_pos = false
var pos = Vector2.ZERO

func _physics_process(delta):
	if change_pos:
		global_position = pos
		change_pos = false

func set_position(pos:Vector2):
	self.pos = pos
	change_pos = true
