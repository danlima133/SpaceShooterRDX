extends Node2D

onready var hit_box = $hit_box

func _process(delta):
	hit_box.global_position = get_global_mouse_position()

func _on_hurt_box_hurtEvent(hitBox):
	print("hurtEvent: " + str(hitBox.id))
	
func _on_hit_box_hitEvent(hurtBox):
	print("hitEvent: " + str(hurtBox.id))
