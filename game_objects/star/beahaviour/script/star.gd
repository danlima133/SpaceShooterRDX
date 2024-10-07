extends ObjectProcess

const Groups = preload("res://libs/groups.lib.gd")

onready var action_box = $"../../action_box"

var improvement:Componet

var _manger_group =  Groups.Manager.new()

var _can_flow_target = false
var _target = null
var _dir = Vector2.ZERO

export(int) var _velocity_to_target

func _ready():
	_manger_group.initManager(self)
	
	if _manger_group.hasTagOnGroup("game", "player"):
		_target = _manger_group.getMemberWithTag("game", "player").getOutputObject()

func _spaw(data:Dictionary = {}):
	randomize()
	
	getObjetcRoot().global_position = data["position"]
	
	var anim = get_tree().create_tween()
	
	var positionX = rand_range(-150, 150)
	var positionY = rand_range(-150, 150)
	positionX = clamp(positionX, (positionX * 75) / abs(positionX), (positionX * 150) / abs(positionX))
	positionY = clamp(positionY, (positionY * 75) / abs(positionY), (positionY * 150) / abs(positionY))
	var position = getObjetcRoot().global_position + Vector2(positionX, positionY)
	
	anim.set_ease(Tween.EASE_OUT)
	anim.set_trans(Tween.TRANS_CUBIC)
	
	getObjetcRoot().show()
	anim.tween_property(getObjetcRoot(), "global_position", position, rand_range(0.5, 1))
	yield(anim, "finished")
	improvement.tryImprovementStar(0.5, data["posibilities"])
	yield(improvement, "finished")
	action_box.setActive(true)
	
	if _target != null:
		_can_flow_target = true

func _process_on_spaw(delta):
	if _can_flow_target:
		_dir = getObjetcRoot().global_position.direction_to(_target.global_position).normalized()
		getObjetcRoot().translate(_dir * Vector2(_velocity_to_target, _velocity_to_target) * delta)

func _reset(data:Dictionary = {}):
	getObjetcRoot().hide()
	action_box.setActive(false)
	improvement._resetImprovements()
	_can_flow_target = false

func _on_ManagerComponets_MangerComponetsInitialize(componetsInit, manager:ManagerComponets):
	improvement = manager.getComponet(0)
	
	improvement.connect("level_max", self, "_starLevelMax")
	improvement.connect("failed_up", self, "_starFailedUp")

func _starLevelMax():
	pass

func _starFailedUp():
	pass
