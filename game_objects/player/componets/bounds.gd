extends Componet

const Groups = preload("res://libs/groups.lib.gd")

export(float) var radius = 0

onready var texture = $"../../texture"

onready var player = get_parent().get_parent() as Player

var _warning = false

var player_flags:Componet

var _manager_groups = Groups.Manager.new()
var _validated_area:ValidatedArea

func _init_componet():
	_manager_groups.initManager(self)
	
	if _manager_groups.hasTagOnGroup("level", "area"):
		_validated_area = _manager_groups.getMemberWithTag("level", "area").getOutputObject()

func getWarning() -> bool:
	return _warning

func _on_ManagerComponets_MangerComponetsInitialize(componetsInit, manager):
	player_flags = currentManager.getComponet(1)

func _setterWarnig(value):
	if player_flags.getFlagState("bounds"):
		_warning = value

func _process(_delta):
	if _validated_area.is_valid_position(player.global_position, radius):
		_setterWarnig(false)
	else:
		_setterWarnig(true)
