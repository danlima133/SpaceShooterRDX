extends Node2D

onready var motionEngine = $Sprite/MotionEngine
onready var motionEngine2 = $Sprite5/MotionEngine

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_S:
					motionEngine.setActive(!motionEngine.getActive())
					motionEngine2.setActive(!motionEngine2.getActive())
