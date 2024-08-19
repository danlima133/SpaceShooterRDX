extends ObjectProcess

onready var hurt_box = $"../../hurt_box"
onready var hit_box = $"../../hit_box"
onready var motion_engine = $"../../MotionEngine"
onready var texture = $"../../texture"

var meteorControl:Componet

func _object_enter():
	getObjectManger()._reset()
	motion_engine.getObjectMove().connect("event", self, "_motionEngineEvents")

func _spaw(data:Dictionary):
	getObjetcRoot().global_position = data["position"]
	
	hurt_box.setActive(true)
	hit_box.setActive(true)
	
	if data.has("meteor_data"):
		meteorControl.setMeteor(data["meteor_data"])
	else:
		meteorControl.setMeteor()
	
	randomize()
	motion_engine.setActive(true)
	motion_engine.getObjectMove().setDir(Vector2(rand_range(-1, 1), 0))
	motion_engine.getObjectMove().move(false, false)
		
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

func _on_checker_screen_exited():
	getObjectManger()._reset()

func _on_hit_box_hitEvent(hurtBox):
	getObjectManger()._reset()
	
func _on_hurt_box_hurtNoValue(hurtBox):
	getObjectManger()._reset()

func _on_hurt_box_hurtEvent(hurtBox):
	$"../../hurt".text = str(hurt_box.getHurt())
