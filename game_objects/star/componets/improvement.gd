extends Componet

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

func tryImprovementStar(deley:float):
	yield(get_tree().create_timer(deley), "timeout")
	randomize()
	
	var flow = (randi() % 10)
	
	if flow > 5:
		_currentLevel += 1
		emit_signal("up")
		if _currentLevel < 3:
			tryImprovementStar(deley)
		else:
			emit_signal("level_max")
			emit_signal("finished")
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
