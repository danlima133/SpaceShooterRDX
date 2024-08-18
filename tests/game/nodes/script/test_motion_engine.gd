extends RigidBody2D

onready var motionEngine = $MotionEngine

func event(event, data):
	print(event, data)

func _on_MotionEngine_start(motionEngine):
	motionEngine.getObjectMove().connect("event", self, "event")

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_M:
					motionEngine.getObjectMove().move()
				KEY_0:
					motionEngine.setActive(false)
				KEY_1:
					motionEngine.setActive(true)
