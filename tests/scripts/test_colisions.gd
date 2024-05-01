extends Node2D

onready var hit_box = $hit_box

onready var hurt_box = $hurt_box
onready var hurt_box2 = $hurt_box2

onready var label = $Label
onready var label_2 = $Label2

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_0:
					hurt_box2.setHurtMax(300)
				KEY_1:
					hurt_box2.hurt(20, hurt_box2.PLUS)
					hurt_box2.setHurtLimit(-100)
				KEY_2:
					hurt_box2.hurt(200)
				KEY_3:
					hit_box.setHitContinues(!hit_box.getHitContinues())
			#hit_box.setTimerHit(0.3)
			#hit_box.setActive(!hit_box.getActive(), {
				#"all": false,
				#"shapeIdx": [ 1, 2 ]
			#})

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

func _on_hurt_box2_update(property, value, box:HurtBox):
	match property:
		box.propertyNames.HURT_MAX:
			print("set max hurt")
			label_2.text = str(box.getHurt()) + "/" + str(value)
		box.propertyNames.HURT_LIMIT:
			print("set limit hurt")

func _on_hit_box_updateProperty(property, value, box:HitBox):
	match property:
		box.propertyNames.HIT_CONTINUES:
			print("set hit continues")
