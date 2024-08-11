extends ObjectProcess

onready var hurt_box = $"../../hurt_box"
onready var hit_box = $"../../hit_box"
onready var motion_engine = $"../../MotionEngine"
onready var texture = $"../../texture"

var meteorControl:Componet

func _object_enter():
	getObjectManger()._reset()

func _spaw(data:Dictionary):
	getObjetcRoot().global_position = data["position"]
	
	hurt_box.setActive(true)
	hit_box.setActive(true)
	
	if data.has("meteor_data"):
		meteorControl.setMeteor(data["meteor_data"])
	else:
		meteorControl.setMeteor()
	
	if data.has("motion_config"):
		motion_engine.updateDir(data["motion_config"], false)
		motion_engine.setActive(true)
	else:
		motion_engine.setActive(true)
		
	getObjetcRoot().show()

func _reset(data:Dictionary):
	getObjetcRoot().hide()
	meteorControl._currentData = {}
	texture.texture = null
	
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
