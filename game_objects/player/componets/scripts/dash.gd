extends Componet

signal dashConclusion

export(int) var dashForce

onready var move = $move
onready var player = $"../.."

var playerFlags:Componet

func playerDash(direction:Vector2, force = dashForce):
	playerFlags.setFlagState("movement", false)
	
	var pointFinal = player.global_position + (direction * force)
	
	move.interpolate_property(player, "global_position", player.global_position, pointFinal, 0.2, Tween.TRANS_CUBIC, Tween.EASE_OUT)
	move.start()

func _process(delta):
	if Input.is_action_just_pressed("player_dash"):
		playerDash(player.playerLastDir)
	
func _on_move_tween_all_completed():
	playerFlags.setFlagState("movement", true)
	emit_signal("dashConclusion")

func _on_manager_componets_MangerComponetsInitialize(componetsInit, manager:ManagerComponets):
	playerFlags = manager.getComponet(1)
