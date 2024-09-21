extends Node

var level_data:LevelData

func _on_ManagerComponets_MangerComponetsInitialize(componetsInit, manager:ManagerComponets):
	level_data = manager.getComponet(0) as LevelData
	level_data.set_value(level_data.Refs.Scope.STARS, level_data.Refs.Token.SILVIER, 10)
	var data = level_data.export_data({ "scopes": [level_data.Refs.Scope.STARS] })
	print(data)
