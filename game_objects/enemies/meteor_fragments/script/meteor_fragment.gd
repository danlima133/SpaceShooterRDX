extends RigidBody2D

var pos = Vector2.ZERO

func _ready():
	set_physics_process(false)

func _physics_process(delta):
	global_position = pos
	set_physics_process(false)

func set_position(pos:Vector2):
	self.pos = pos
	set_physics_process(true)
