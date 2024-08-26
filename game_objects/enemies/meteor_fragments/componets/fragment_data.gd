extends Componet

const DynamicResources = preload("res://libs/resource_dynamic.lib.gd")

var _currentData:MeteorFragment

onready var texture = $"../../texture"
onready var motion_engine = $"../../MotionEngine"
onready var hit_box = $"../../hit_box"
onready var hurt_box = $"../../hurt_box"

func setData(data:MeteorFragment):
	texture.texture = data.texture
	
	var velocity:float
	
	if DynamicResources.isRangeValue(data.velocity):
		velocity = DynamicResources.generateRangeValue(data.velocity, DynamicResources.TypeRand.FLOAT)
	else:
		velocity = DynamicResources.getValueFromRand(data.velocity, DynamicResources.Value.DEFAULT)
	
	motion_engine.getObjectMove().setVelocity(velocity)
	
	hit_box.setHit(data.damage)
	hurt_box.setHurtMax(data.resistence, true)
	
	var shape = CircleShape2D.new()
	shape.radius = texture.texture.get_width()/2 - data.meteorTreshoald
	
	hurt_box.get_node("shape").set_deferred("shape", shape)
	hit_box.get_node("shape").set_deferred("shape", shape)
	
	shape.radius -= data.meteorTreshoald
	shape.radius += 5
	
	currentManager.get_parent().get_node("shape").set_deferred("shape", shape)

func getCurrentData():
	return _currentData
