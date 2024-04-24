extends Node2D

onready var attributes = $attributes
onready var player_flags = $player_flags

onready var texture = $texture

func _movement(delta):
	var dir = Input.get_vector("player_left", "player_right", "player_up", "player_down").normalized()
	translate(dir * attributes.getVelocity() * delta)

func _physics_process(delta):
	if player_flags.getFlagState(player_flags.MOVEMENT):
		_movement(delta)
