extends Node

export(NodePath) var rootMotionPath
export(Resource) var motionConfig

var _dir:Vector2
var _velocity:float

var _xDir:float
var _yDir:float

var _active = true

func getRootMotion() -> Node2D:
	return get_node(rootMotionPath) as Node2D

func getMoveByRulesAndConfig() -> Vector2:
	randomize()
	
	_velocity = motionConfig.velocity
	if motionConfig.velocityRandom:
		_velocity = rand_range(motionConfig.velocityMin, motionConfig.velocityMax)
	
	if motionConfig.directionRandom:
		_xDir = rand_range(-1, 1)
		_yDir = rand_range(-1, 1)
	
	if motionConfig.axioFix["axioX"]["fix"]:
		_xDir = motionConfig.axioFix["axioX"]["value"]
	elif !motionConfig.directionRandom:
		_xDir = motionConfig.direction.x
	if motionConfig.axioFix["axioY"]["fix"]:
		_yDir = motionConfig.axioFix["axioY"]["value"]
	elif !motionConfig.directionRandom:
		_yDir = motionConfig.direction.y
	
	return Vector2(_xDir, _yDir)

func setActive(value):
	_active = value
	set_physics_process(_active)

func getActive() -> bool:
	return _active

func _move(delta):
	getRootMotion().translate(_dir * delta * _velocity)

func _ready():
	if motionConfig is MotionConfig:
		_dir = getMoveByRulesAndConfig()
		print(_dir)
	else: printerr("The motion engine: %s not have motion config" % self)

func _physics_process(delta):
	_move(delta)
