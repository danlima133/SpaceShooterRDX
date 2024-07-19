extends Componet

onready var shoot_point = $"../../shoot_point"
onready var object_pooling = $"../../object_pooling"

var playerFlags:Componet
var attributes:Componet

func _process(delta):
	if Input.is_action_just_pressed("player_shoot"):
		if playerFlags.getFlagState("shoot"):
			object_pooling.spaw({ "group": "bullets" }, { 
				"position": shoot_point.global_position, 
				"damage": attributes.getDamage()
				})

func _on_ManagerComponets_MangerComponetsInitialize(componetsInit, manager):
	playerFlags = manager.getComponet(1)
	attributes = manager.getComponet(0)
