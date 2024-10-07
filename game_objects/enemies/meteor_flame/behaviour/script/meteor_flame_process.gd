extends ObjectProcess

const Groups = preload("res://libs/groups.lib.gd")

onready var hit_box = $"../../hit_box"
onready var action_box = $"../../action_box"
onready var motion_engine = $"../../MotionEngine"

var _manager_groups = Groups.Manager.new()
var _validated_area:ValidatedArea

func _ready():
	_manager_groups.initManager(self)
	
	if _manager_groups.hasTagOnGroup("level", "area"):
		var __member = _manager_groups.getMemberWithTag("level", "area") as MemberGroup
		_validated_area = __member.getOutputObject()

func _spaw(data:Dictionary = {}):
	getObjetcRoot().global_position = data["position"]
	getObjetcRoot().show()
	
	action_box.setActive(true)
	hit_box.setActive(true)
	motion_engine.setActive(true)

func _process_on_spaw(delta):
	if not _validated_area.is_valid_position(getObjetcRoot().global_position, 250):
		getObjectManger()._reset()

func _reset(data:Dictionary = {}):
	getObjetcRoot().hide()
	getObjetcRoot().global_position = Vector2.ZERO
	
	hit_box.setActive(false)
	action_box.setActive(false)
	motion_engine.setActive(false)
