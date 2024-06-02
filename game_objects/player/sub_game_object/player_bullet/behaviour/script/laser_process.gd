extends ObjectProcess

func _objectEnter():
	getObjetcRoot().hide()

func _spaw(data:Dictionary):
	getObjetcRoot().get_node("motion_engine").setActive(true)
	
	getObjetcRoot().get_node("hit_box").setActive(true)
	if data.has("damage"):
		getObjetcRoot().get_node("hit_box").setHit(data["damage"])
	
	getObjetcRoot().show()
	getObjetcRoot().global_position = data["position"]

func _reset(data:Dictionary):
	getObjetcRoot().get_node("motion_engine").setActive(false)
	getObjetcRoot().get_node("hit_box").setActive(false)
	getObjetcRoot().hide()
	getObjetcRoot().global_position = Vector2.ZERO

func _on_controller_reset_screen_exited():
	getObjectManger()._reset()

# -- This block code is a test --
func _on_hit_box_hitEvent(hitBox):
	getObjectManger()._reset()
# -- end --
