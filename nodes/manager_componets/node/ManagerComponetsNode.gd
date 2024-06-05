extends Node
class_name ManagerComponets, "res://nodes/manager_componets/icon/node.png"

signal MangerComponetsInitialize(componetsInit, manager)

export(Array, NodePath) var _componets
export(bool) var getChilds = true

func _ready():
	_componets = _getComponetsByPath(_componets)
	if getChilds:
		_componets.append_array(get_children())
	
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

func _getComponetsByPath(paths:Array) -> Array:
	var componets:Array
	
	for path in paths:
		var component = get_node(path)
		componets.append(component)
	
	return componets

func _initialazeComponets():
	for componet in _componets:
		componet.currentManager = self
		componet._init_componet()
	emit_signal("MangerComponetsInitialize", _componets.size(), self)
