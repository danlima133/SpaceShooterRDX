extends Node2D

onready var hit_box = $hit_box

onready var hurt_box = $hurt_box
onready var hurt_box2 = $hurt_box2

onready var label = $Label
onready var label_2 = $Label2

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and event.pressed:
			hit_box.setActive(!hit_box.getActive(), {
				"all": false,
				"shapeIdx": [ 1, 2 ]
			})

func _process(delta):
	hit_box.global_position = get_global_mouse_position()

func _ready():
	label.text = str(hurt_box.getHurt()) + "/" + str(hurt_box.getHurtMax())
	label_2.text = str(hurt_box2.getHurt()) + "/" + str(hurt_box2.getHurtMax())

func _on_hurt_box_hurtEvent(hurtBox:HurtBox):
	label.text = str(hurtBox.getHurt()) + "/" + str(hurtBox.getHurtMax())

func _on_hurt_box_hurtNoValue(hurtBox):
	#hit_box.hide()
	#var shapesChange = hit_box.setActive(false)
	#print(shapesChange)
	hurtBox.hurt(80, hurt_box.PLUS)

func _on_hurt_box2_hurtEvent(hurtBox):
	label_2.text = str(hurtBox.getHurt()) + "/" + str(hurtBox.getHurtMax())

func _on_hurt_box2_hurtNoValue(hurtBox):
	hurtBox.hide()
	
