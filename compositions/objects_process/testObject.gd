extends ObjectProcess

onready var lifetime = $"../lifetime"

func _objectEnter():
	getObjetcRoot().hide()
	print_debug()

func _reset(data:Dictionary):
	get_parent().hide()

func _spaw(data:Dictionary):
	get_parent().show()
	get_parent().global_position = data.position
	lifetime.start()

func _on_lifetime_timeout():
	getObjectManger()._reset()
