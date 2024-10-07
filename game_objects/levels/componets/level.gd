extends Componet

export(NodePath) var _background_path

var _background

func _init_componet():
	if has_node(_background_path):
		_background = get_node(_background)

func set_leve():
	var level_area = _background.get_area_level()
	
