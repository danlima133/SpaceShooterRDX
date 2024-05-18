extends Node2D

var meteorControl:Componet

func _on_hurt_box_hurtNoValue(hurtBox):
	pass

func _on_manager_componets_MangerComponetsInitialize(componetsInit, manager:ManagerComponets):
	meteorControl = manager.getComponet(45)
