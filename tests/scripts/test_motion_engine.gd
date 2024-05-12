extends Node2D

onready var motionEngine = $Sprite/motion_engine
onready var motionEngine2 = $Sprite5/motion_engine

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_S:
					motionEngine.setActive(!motionEngine.getActive())
					motionEngine2.setActive(!motionEngine2.getActive())
