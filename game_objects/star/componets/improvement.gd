extends Componet

const RegularMath = preload("res://libs/regular_math.lib.gd")

signal up
signal level_max
signal failed_up
signal finished

enum Star {
	BRONZE
	SILVIER
	GOLD
}

const starsTextures = {
	"bronze": preload("res://assets/sprites/power_ups/star_bronze.png"),
	"silvier": preload("res://assets/sprites/power_ups/star_silver.png"),
	"gold": preload("res://assets/sprites/power_ups/star_gold.png")
}

onready var texture = $"../../texture"

var _currentLevel:int = 1
var _currentStar:int = Star.BRONZE

var dynamic_posibilities = RegularMath.Radom.DynamicPosibilities.new()

func _init_componet():
	var random_input = RegularMath.Radom.DynamicPosibilities.RandomInput.new()
	
	random_input.set_input({
		"percent_base": RegularMath.percent_to_decimal(3),
		"percent_bonus": RegularMath.percent_to_decimal(2.5),
		"percent_fall": RegularMath.percent_to_decimal(4),
		"height_succsse": 5,
		"height_fall": 3
	})
	
	dynamic_posibilities.randomize()
	dynamic_posibilities.set_random_input(random_input)

func getStar() -> int:
	return _currentStar

func tryImprovementStar(deley:float):
	yield(get_tree().create_timer(deley), "timeout")
	randomize()
	
	var posibility:RegularMath.Radom.Posibility = dynamic_posibilities.get_posibility()
	
	if posibility.case == RegularMath.Radom.Posibility.Cases.SUCCSSE:
		_currentLevel += 1
		emit_signal("up")
		if _currentLevel < 3:
			tryImprovementStar(deley)
		else:
			emit_signal("level_max")
	else:
		emit_signal("failed_up")
	
	emit_signal("finished")
	
	_setUp()

func _setUp():
	match _currentLevel:
		2:
			texture.texture = starsTextures["silvier"]
			_currentStar = Star.SILVIER
		3:
			texture.texture = starsTextures["gold"]
			_currentStar = Star.GOLD

func _resetImprovements():
	_currentLevel = 1
	_currentStar = Star.BRONZE
	texture.texture = starsTextures["bronze"]
