extends ObjectProcess

onready var hit_box = $"../../hit_box"
onready var action_box = $"../../action_box"
onready var motion_engine = $"../../MotionEngine"

func _spaw(data:Dictionary):
	getObjetcRoot().global_position = data["position"]
	getObjetcRoot().show()
	
	action_box.setActive(true)
	hit_box.setActive(true)
	motion_engine.setActive(true)

func _reset(data:Dictionary):
	getObjetcRoot().hide()
	getObjetcRoot().global_position = Vector2.ZERO
	
	hit_box.setActive(false)
	action_box.setActive(false)
	motion_engine.setActive(false)

func _on_checker_screen_exited():
	getObjectManger()._reset()
