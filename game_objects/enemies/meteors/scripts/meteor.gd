extends ObjectProcess

onready var hurt_box = $"../../hurt_box"
onready var hit_box = $"../../hit_box"

onready var life_time = $life_time

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
	
	getObjetcRoot().show()
	_setLifeTime()

func _reset(data:Dictionary):
	getObjetcRoot().hide()
	
	hurt_box.setActive(false)
	hit_box.setActive(false)

func _setLifeTime():
	randomize()
	
	life_time.wait_time = rand_range(4, 7)
	life_time.start()

func _on_manager_componets_MangerComponetsInitialize(componetsInit, manager:ManagerComponets):
	meteorControl = manager.getComponet(45)

func _on_life_time_timeout():
	getObjectManger()._reset()
