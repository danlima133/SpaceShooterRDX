extends Componet

onready var shoot_point = $"../../shoot_point"
onready var object_pooling = $"../../object_pooling"
onready var player_flags = $"../player_flags"

func _process(delta):
	if Input.is_action_just_pressed("player_shoot"):
		if player_flags.getFlagState("shoot"):
			object_pooling.spaw({ "group": "bullets" }, { "position": shoot_point.global_position })
			
