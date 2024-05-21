extends Node2D

onready var hurt_label = $hurt_label
onready var hurt_box = $hurt_box

onready var originPosition = global_position

func _ready():
	_setLabel(hurt_box.getHurt(), hurt_box.getHurtMax())

func _on_hurt_box_hurtEvent(hurtBox:HurtBox):
	_setLabel(hurtBox.getHurt(), hurtBox.getHurtMax())

func _on_hurt_box_hurtNoValue(_hurtBox:HurtBox):
	print(_hurtBox.getHurt())
	queue_free()

func _setLabel(value:float, maxValue:float):
	hurt_label.text =  str(value) + "/" + str(maxValue)

func _on_controler_reset_screen_exited():
	global_position = originPosition
