extends Componet

export(int) var rangeMax = 1

onready var visibility = $"../../visibility"
onready var texture = $"../../texture"

onready var player = get_parent().get_parent() as Player

onready var manager_componets = $".."

var _warning = false

var player_flags:Componet

func getWarning() -> bool:
	return _warning

func _on_visibility_screen_exited():
	_setterWarnig(true)
	
func _on_visibility_screen_entered():
	_setterWarnig(false)

func _on_ManagerComponets_MangerComponetsInitialize(componetsInit, manager):
	player_flags = currentManager.getComponet(1)

func _setterWarnig(value):
	if player_flags.getFlagState("bounds"):
		_warning = value

func _process(_delta):
	visibility.position = (player.playerLastDir * texture.texture.get_size()) * Vector2(rangeMax, rangeMax)
