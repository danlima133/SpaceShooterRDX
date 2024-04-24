extends Node

onready var player_flags = $"../player_flags"

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
	print(_warning)
