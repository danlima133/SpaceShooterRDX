extends ObjectProcess

onready var motionEngine = $"../MotionEngine"

func _objectEnter():
	getObjetcRoot().hide()

func _spaw(data:Dictionary = {}):
	getObjetcRoot().get_node("hit_box").setActive(true)
	if data.has("damage"):
		getObjetcRoot().get_node("hit_box").setHit(data["damage"])
	
	getObjetcRoot().global_position = data["position"]
	motionEngine.getObjectMove().setPreConfigs({
		"dirTarget": false
	})
	motionEngine.getObjectMove().setDir(getObjetcRoot().global_position.direction_to(data["target"]))
	motionEngine.setActive(true)
	getObjetcRoot().look_at(data["target"])
	getObjetcRoot().show()

func _reset(data:Dictionary = {}):
	getObjetcRoot().get_node("hit_box").setActive(false)
	getObjetcRoot().get_node("MotionEngine").setActive(false)
	getObjetcRoot().hide()
	getObjetcRoot().global_position = Vector2.ZERO

func _on_controller_reset_screen_exited():
	getObjectManger()._reset()

# -- This block code is a test --
func _on_hit_box_hitEvent(hitBox):
	var root = hitBox.get_parent()
	if root.has_node("MotionEngine"):
		var ME = root.get_node("MotionEngine")
		ME.getObjectMove().setDir(Vector2(0, -1))
		if ME.typeMotionBody == ME.motionBody.RIGBODY:
			ME.getObjectMove().impulse(false, 80)
	getObjectManger()._reset()
# -- end --

func _on_target_box_action(action:String, triger:CollisionBox, target:TargetBox, type:int):
	if action == "killPlayerBullet":
		getObjectManger()._reset()
