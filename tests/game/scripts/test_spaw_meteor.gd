extends Node

onready var meteors = $object_pooling
onready var coldown = $coldown

func _ready():
	_spaw()

func _spaw():
	randomize()
	
	var xRand = rand_range(0, 1024)
	var yRand = rand_range(0, 680)
	
	meteors.spaw({ "group": "meteors" }, {
		"position": Vector2(xRand, yRand)
	})
	_setColdown()

func _setColdown():
	coldown.wait_time = rand_range(2, 4)
	coldown.start()

func _on_coldown_timeout():
	_spaw()
