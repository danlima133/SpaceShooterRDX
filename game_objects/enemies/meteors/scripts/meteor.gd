extends ObjectProcess

onready var hurt_box = $"../../hurt_box"
onready var hit_box = $"../../hit_box"
onready var motion_engine = $"../../MotionEngine"

var meteorControl:Componet

func _object_enter():
	getObjectManger()._reset()

func _spaw(data:Dictionary):
	getObjetcRoot().global_position = data["position"]
	
	hurt_box.setActive(true)
	hit_box.setActive(true)
	
	if data.has("meteor_type"):
		meteorControl.setMeteor(data["meteor_type"])
	
	meteorControl.setMeteor()
	
	motion_engine.setActive(true)
	
	getObjetcRoot().show()

func _reset(data:Dictionary):
	getObjetcRoot().hide()
	
	hurt_box.setActive(false)
	hit_box.setActive(false)
	
	motion_engine.setActive(false)

func _on_ManagerComponets_MangerComponetsInitialize(componetsInit, manager):
	meteorControl = manager.getComponet(45)

func _on_hurt_box_hurtEvent(hurtBox):
	getObjetcRoot().global_position.y -= 20

func _on_hit_box_hitEvent(hitBox):
	getObjectManger()._reset()

func _on_hurt_box_hurtNoValue(hurtBox):
	getObjectManger()._reset()
	
func _on_checker_screen_exited():
	getObjectManger()._reset()
