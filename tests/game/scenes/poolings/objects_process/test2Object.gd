extends ObjectProcess

onready var lifetime = $"../lifetime"

func _ready():
	randomize()

func _objectEnter():
	get_parent().hide()
	get_parent().global_position = Vector2.ZERO

func _reset(data:Dictionary = {}):
	get_parent().hide()
	get_parent().global_position = Vector2.ZERO

func _spaw(data:Dictionary = {}):
	get_parent().show()
	get_parent().global_position = Vector2(rand_range(0, 1024), rand_range(0, 680))
	
	lifetime.wait_time = data["lifetime"]
	lifetime.start()
	
	print(data["idx"])

func _on_lifetime_timeout():
	getObjectManger()._reset()
