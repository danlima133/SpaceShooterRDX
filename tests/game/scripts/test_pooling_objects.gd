extends Node

onready var object_pooling = $object_pooling

var _idx = 0

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_0:
					gen_objects(10)

func _ready():
	gen_objects(25)

func gen_objects(count):
	var function = funcref(self, "_data_spaw")
	object_pooling.spaw({ "group": "o1", "count": count, "metafunction": { "function": function, "args": [] }})

func _data_spaw():
	_idx += 1
	return {
		"idx": _idx,
		"lifetime": 20
	}
