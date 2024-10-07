extends ObjectProcess

const DynamicResources = preload("res://libs/resource_dynamic.lib.gd")
const RegularMath = preload("res://libs/regular_math.lib.gd")
const Groups = preload("res://libs/groups.lib.gd")

onready var hurt_box = $"../../hurt_box"
onready var hit_box = $"../../hit_box"
onready var motion_engine = $"../../MotionEngine"
onready var texture = $"../../texture"
onready var object_pooling = $"../../object_pooling"
onready var shape = $"../../shape"

var meteorControl:Componet

var __dynamic_posibilities = RegularMath.Radom.DynamicPosibilities.new()

var _manager_group = Groups.Manager.new()
var _validated_area:ValidatedArea

func _ready():
	_manager_group.initManager(self)
	
	if _manager_group.hasTagOnGroup("level", "area"):
		_validated_area = _manager_group.getMemberWithTag("level", "area").getOutputObject()

func _object_enter():
	getObjectManger()._reset()
	motion_engine.getObjectMove().connect("event", self, "_motionEngineEvents")

	var random_input = RegularMath.Radom.DynamicPosibilities.RandomInput.new()
	
	random_input.set_input({
		"percent_base": RegularMath.percent_to_decimal(5),
		"percent_bonus": RegularMath.percent_to_decimal(2),
		"percent_fall": RegularMath.percent_to_decimal(4),
		"height_succsse": 6,
		"height_fall": 2
	})
	
	__dynamic_posibilities.randomize()
	__dynamic_posibilities.set_random_input(random_input)

func _spaw(data:Dictionary = {}):
	getObjetcRoot().position = data["position"]
	
	hurt_box.setActive(true)
	hit_box.setActive(true)
	shape.set_deferred("disabled", false)
	
	if data.has("meteor_data"):
		meteorControl.setMeteor(data["meteor_data"])
	else:
		meteorControl.setMeteor()
	
	randomize()
	motion_engine.setActive(true)
	motion_engine.getObjectMove().setDir(Vector2(rand_range(-1, 1), 0))
	motion_engine.getObjectMove().move(false, false)
		
	getObjetcRoot().show()

func _process_on_spaw(delta):
	if not _validated_area.is_valid_position(getObjetcRoot().global_position, 250):
		getObjectManger()._reset()

func _reset(data:Dictionary = {}):
	getObjetcRoot().hide()
	getObjetcRoot().global_position = Vector2.ZERO
	getObjetcRoot().sleeping = true
	meteorControl._currentData = null
	texture.texture = null
	
	hurt_box.setActive(false)
	hit_box.setActive(false)
	shape.set_deferred("disabled", true)
	
	motion_engine.setActive(false)

func _on_ManagerComponets_MangerComponetsInitialize(componetsInit, manager):
	meteorControl = manager.getComponet(45)

func _on_hit_box_hitEvent(hurtBox):
	getObjectManger()._reset()
	
func _on_hurt_box_hurtNoValue(hurtBox):
	var countFragments = meteorControl.getCurrentData().fragmentsCount
	var fragmentsAnvaliable = meteorControl.getCurrentData().fragments
	
	var fragment
	
	if DynamicResources.isRangeValue(countFragments):
		countFragments = DynamicResources.generateRangeValue(countFragments, DynamicResources.TypeRand.INT)
	else:
		countFragments = DynamicResources.getValueFromRand(countFragments, DynamicResources.Value.DEFAULT)
	
	if DynamicResources.isRangeValue(fragmentsAnvaliable):
		fragment = DynamicResources.getRandonValueFromRand(fragmentsAnvaliable)
	else:
		fragment = DynamicResources.getValueFromRand(fragmentsAnvaliable, DynamicResources.Value.DEFAULT)
		
	if fragment == null:
		getObjectManger()._reset()
		return
	
	var obj = object_pooling.spaw({ "group": "fragments", "count": countFragments }, {
			"position": getObjetcRoot().position,
			"fragment": fragment
		})
	getObjectManger()._reset()

func _on_hurt_box_hurtEvent(hitBox):
	pass
#	motion_engine.getObjectMove().setDir(-(hitBox.global_position).normalized())
#	motion_engine.getObjectMove().impulse(false, 250)
