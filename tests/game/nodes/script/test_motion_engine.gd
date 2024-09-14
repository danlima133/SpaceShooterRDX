extends Node2D

onready var motionEngine = $body/MotionEngine
onready var motionEngine2 = $body2/MotionEngine
onready var motionEngine3 = $body3/MotionEngine
onready var motionEngine4 = $bullet/MotionEngine


func event(event, data):
	print(event)
	if event == "collideEnter":
		var collider = data["collider"]
		var collisor = data["collisor"]
		print(collider, collisor)
		if collider.name == "bullet":
			collider.queue_free()

func _on_MotionEngine_start(motionEngine):
	motionEngine.getObjectMove().connect("event", self, "event")

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_M:
					motionEngine.getObjectMove().move()
					motionEngine2.getObjectMove().move()
					motionEngine3.getObjectMove().move()
				KEY_0:
					motionEngine.setActive(false)
					motionEngine2.setActive(false)
					motionEngine3.setActive(false)
				KEY_1:
					motionEngine.setActive(true)
					motionEngine2.setActive(true)
					motionEngine3.setActive(true)
					motionEngine4.setActive(true)
