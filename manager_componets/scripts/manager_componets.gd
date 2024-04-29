extends Node
class_name ManagerComponets

signal MangerComponetsInitialize(componetsInit, manager)

var _componets:Array

func _ready():
	_componets = get_children()
	_initialazeComponets()

func getComponetsId() -> Array:
	var ids = []
	for componet in _componets:
		ids.append(componet.getId())
	return ids

func getComponet(id:int):
	for componet in _componets:
		if id == componet.getId():
			return componet
	return null

func _initialazeComponets():
	for componet in _componets:
		componet._init_componet()
	emit_signal("MangerComponetsInitialize", _componets.size(), self)
