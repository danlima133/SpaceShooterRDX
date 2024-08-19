extends RigidBody2D

var pos:Vector2
var dir:Vector2

func _input(event):
	if event is InputEventMouse:
		if event.button_mask == BUTTON_LEFT and event.is_pressed():
			$MotionEngine.setActive(true)
			$MotionEngine.getObjectMove().setDir(global_position.direction_to(event.position))
			dir = $MotionEngine.getObjectMove().getDir(false)
			pos = get_global_mouse_position()
			$MotionEngine.getObjectMove().impulse(false)

func _integrate_forces(state):
	look_at(pos)
	rotation += deg2rad(90)
