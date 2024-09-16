extends ObjectProcess

signal arrive

onready var action_box = $"../../action_box"

var improvement:Componet

func _spaw(data:Dictionary = {}):
	randomize()
	
	getObjetcRoot().global_position = data["position"]
	
	var anim = get_tree().create_tween()
	
	var positionX = rand_range(-150, 150)
	var positionY = rand_range(-150, 150)
	positionX = clamp(positionX, (positionX * 75) / abs(positionX), (positionX * 150) / abs(positionX))
	positionY = clamp(positionY, (positionY * 75) / abs(positionY), (positionY * 150) / abs(positionY))
	var position = getObjetcRoot().global_position + Vector2(positionX, positionY)
	print(position - getObjetcRoot().global_position)
	
	anim.set_ease(Tween.EASE_OUT)
	anim.set_trans(Tween.TRANS_CUBIC)
	
	getObjetcRoot().show()
	anim.tween_property(getObjetcRoot(), "global_position", position, rand_range(0.5, 1))
	yield(anim, "finished")
	improvement.tryImprovementStar(0.5)
	yield(improvement, "finished")
	action_box.setActive(true)
	
func _reset(data:Dictionary = {}):
	getObjetcRoot().hide()
	action_box.setActive(false)
	improvement._resetImprovements()

func _on_ManagerComponets_MangerComponetsInitialize(componetsInit, manager:ManagerComponets):
	improvement = manager.getComponet(0)
	
	improvement.connect("level_max", self, "_starLevelMax")
	improvement.connect("failed_up", self, "_starFailedUp")

func _starLevelMax():
	pass

func _starFailedUp():
	pass
