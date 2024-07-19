extends Node
class_name Componet

export(int, 0, 1000) var _id = 0

var currentManager:ManagerComponets

func setId(value:int):
	for componet in currentManager._componets:
		if componet.getId() == value:
			printerr("The componet can't has same ids")
			return false
	_id = value
	return true

func getId() -> int:
	return _id

func _init_componet():
	pass
