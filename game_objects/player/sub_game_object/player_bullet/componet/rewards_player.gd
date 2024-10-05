extends Componet

const RegularMath = preload("res://libs/regular_math.lib.gd")
const Groups = preload("res://libs/groups.lib.gd")

onready var _object_pooling = $"../../object_pooling"

var _dynamic_count = RegularMath.Radom.DynamicPosibilities.new()
var _dynamic_level_stars = RegularMath.Radom.DynamicPosibilities.new()
var _manager_groups = Groups.Manager.new()

func _init_componet():
	_manager_groups.initManager(self)
	
	var __random_input_1 = _dynamic_count.RandomInput.new()
	__random_input_1.set_input({
		"percent_base": RegularMath.percent_to_decimal(10),
		"percent_bonus": RegularMath.percent_to_decimal(2),
		"percent_fall": RegularMath.percent_to_decimal(5)
	})
	_dynamic_count.set_random_input(__random_input_1)
	
	var __random_input_2 = RegularMath.Radom.DynamicPosibilities.RandomInput.new()
	__random_input_2.set_input({
		"percent_base": RegularMath.percent_to_decimal(5),
		"percent_bonus": RegularMath.percent_to_decimal(2),
		"percent_fall": RegularMath.percent_to_decimal(4),
		"height_succsse": 6,
		"height_fall": 2
	})
	_dynamic_level_stars.set_random_input(__random_input_2)

func set_score_player(score):
	if _manager_groups.hasTagOnGroup("level", "data"):
		var member = _manager_groups.getMemberWithTag("level", "data") as MemberGroup
		var level_data = member.getOutputObject() as LevelData
		level_data.set_value(level_data.Refs.Scope.PLAYER, level_data.Refs.Token.SCORE, score, true)

func generate_stars(position):
	var __count = _dynamic_count.get_posibility_with_count(3)
	var __function_data = funcref(self, "_spaw_function_data")
	_object_pooling.spaw({ "group": "stars", "count": __count, "metafunction": { "function": __function_data, "args": [position] } })

func _spaw_function_data(position):
	var posibilities = _dynamic_level_stars.get_posibility_as_list(3)
	return {
		"position": position,
		"posibilities": posibilities
	}
