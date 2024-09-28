extends Componet

const DynamicResource = preload("res://libs/resource_dynamic.lib.gd")

const fragamentsBrown = "res://assets/meteors/fragaments/"

onready var texture = $"../../texture"
onready var motion_engine = $"../../MotionEngine"

onready var hurt_box = $"../../hurt_box"
onready var hit_box = $"../../hit_box"

export(Array) var meteors

var _currentData

var treshold_shape:float

func _init_componet():
	setMeteor()

func setMeteor(meteor:MeteorData = null):
	randomize()
	
	var meteorData = meteor
	
	if meteor == null:
		if meteors.size() > 1:
			var meteorIndex = randi() % meteors.size()
			meteorData = meteors[meteorIndex]
		else:
			meteorData = meteors[0]
	
	_currentData = meteorData
	
	var shape = CircleShape2D.new()
	shape.radius = (meteorData.texture.get_width()/2) - meteorData.meteorTreshoald
	
	$"../../shape".set_deferred("shape", shape)
	
	var shape2 = shape.duplicate()
	shape2.radius = shape.radius + 8
	
	hurt_box.get_node("shape").set_deferred("shape", shape2)
	hit_box.get_node("shape").set_deferred("shape", shape2)
	
	hurt_box.setHurtMax(meteorData.resistence, true)
	hit_box.setHit(meteorData.damage)
	
	texture.texture = meteorData.texture
	
	var velocity = meteorData.velocity
	if DynamicResource.isRangeValue(velocity):
		velocity = DynamicResource.generateRangeValue(meteorData.velocity, DynamicResource.TypeRand.FLOAT)
	else:
		velocity = DynamicResource.getValueFromRand(meteorData.velocity, DynamicResource.Value.DEFAULT)
	
	motion_engine.getObjectMove().setVelocity(velocity)

func getCurrentData():
	return _currentData
