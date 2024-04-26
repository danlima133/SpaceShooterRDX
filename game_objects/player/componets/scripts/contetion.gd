extends Node

export(int) var rangeMax = 1

onready var visibility = $"../visibility"
onready var player_flags = $"../player_flags"
onready var texture = $"../texture"

onready var player = get_parent() as Player

var _warning = false

func getWaring() -> bool:
	return _warning

func _on_visibility_screen_exited():
	if player_flags.getFlagState(player_flags.BOUNDS):
		_warning = true
		
func _on_visibility_screen_entered():
	if player_flags.getFlagState(player_flags.BOUNDS):
		_warning = false

func _process(delta):
	visibility.position = (player.playerLastDir * texture.texture.get_size()) * Vector2(rangeMax, rangeMax)
	print(getWaring())
