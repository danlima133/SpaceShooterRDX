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

func getStar() -> int:
	return _currentStar

func tryImprovementStar(deley:float, posibilities:Array):
	yield(get_tree().create_timer(deley), "timeout")
	randomize()
		
	var posibility:RegularMath.Radom.Posibility = posibilities.pop_front()
	print(posibility.case)
	
	if posibility.case == posibility.Cases.SUCCSSE:
		_currentLevel += 1
		emit_signal("up")
		if _currentLevel < 3:
			tryImprovementStar(deley, posibilities)
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
