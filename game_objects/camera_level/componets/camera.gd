extends Componet

const Groups = preload("res://libs/groups.lib.gd")

onready var camera = $"../.."

var _manager_groups = Groups.Manager.new()

func _init_componet():
	_manager_groups.initManager(self)
	_config_camera_by_level()

func _config_camera_by_level():
	if _manager_groups.hasTagOnGroup("level", "data"):
		var __member = _manager_groups.getMemberWithTag("level", "data") as MemberGroup
		var __level_data = __member.getOutputObject() as LevelData
		
		camera.limit_left = 0
		camera.limit_top = 0
		camera.limit_right = __level_data.level_size.x
		camera.limit_bottom = __level_data.level_size.y
