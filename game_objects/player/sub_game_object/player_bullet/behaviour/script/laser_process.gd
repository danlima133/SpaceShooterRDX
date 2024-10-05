extends ObjectProcess

onready var motionEngine = $"../MotionEngine"

var safe_position = Vector2.ZERO

var rewards_player:Componet

func _objectEnter():
	getObjetcRoot().hide()

func _spaw(data:Dictionary = {}):
	getObjetcRoot().get_node("MotionEngine").setActive(true)
	
	getObjetcRoot().get_node("hit_box").setActive(true)
	if data.has("damage"):
		getObjetcRoot().get_node("hit_box").setHit(data["damage"])
	
	getObjetcRoot().global_position = data["position"]
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
	safe_position = getObjetcRoot().global_position
	getObjectManger()._reset()
# -- end --

func _on_hit_box_hitKilledHurt(hurtBox):
	rewards_player.set_score_player(10)
	rewards_player.generate_stars(safe_position)

func _on_target_box_action(action:String, triger:CollisionBox, target:TargetBox, type:int):
	if action == "killPlayerBullet":
		getObjectManger()._reset()

func _on_ManagerComponets_MangerComponetsInitialize(componetsInit, manager:ManagerComponets):
	rewards_player = manager.getComponet(0)
