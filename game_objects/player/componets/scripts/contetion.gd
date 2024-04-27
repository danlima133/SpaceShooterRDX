extends Componet

export(int) var rangeMax = 1

onready var visibility = $"../../visibility"
onready var texture = $"../../texture"

onready var player = get_parent().get_parent() as Player

onready var manager_componets = $".."

var _warning = false

var player_flags:Componet

func getWaring() -> bool:
	return _warning

func _on_visibility_screen_exited():
	if player_flags.getFlagState(player_flags.BOUNDS):
		_warning = true
		
func _on_visibility_screen_entered():
	if player_flags.getFlagState(player_flags.BOUNDS):
		_warning = false

func _init_componet():
	player_flags = currentManager.getComponet(1)

func _process(_delta):
	visibility.position = (player.playerLastDir * texture.texture.get_size()) * Vector2(rangeMax, rangeMax)
