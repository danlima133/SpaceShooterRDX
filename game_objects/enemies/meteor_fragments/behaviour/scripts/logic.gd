extends ObjectProcess

onready var motion_engine = $"../../MotionEngine"
onready var texture = $"../../texture"
onready var hit_box = $"../../hit_box"
onready var hurt_box = $"../../hurt_box"
onready var shape = $"../../shape"

var dataMeteor:Componet

func _object_enter():
	_reset()

func _reset(data:Dictionary = {}):
	motion_engine.setActive(false)
	
	texture.hide()
	
	hit_box.setActive(false)
	hurt_box.setActive(false)
	shape.set_deferred("disabled", true)

func _spaw(data:Dictionary = {}):
	getObjetcRoot().global_position = data["position"]
	dataMeteor.setData(data["fragment"])
	
	hit_box.setActive(true)
	hurt_box.setActive(true)
	shape.set_deferred("disabled", false)
	
	texture.show()
	motion_engine.setActive(true)

func _on_ManagerComponets_MangerComponetsInitialize(componetsInit, manager:ManagerComponets):
	dataMeteor = manager.getComponet(450)

func _on_hurt_box_hurtNoValue(hittBox):
	getObjectManger()._reset()

func _on_hit_box_hitEvent(hurtBox):
	getObjectManger()._reset()

func _on_check_screen_exited():
	getObjectManger()._reset()
