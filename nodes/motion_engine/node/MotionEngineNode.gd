extends Node
class_name MotionEngine, "res://nodes/motion_engine/icon/node.png"

const DynamicResource = preload("res://libs/resource_dynamic.lib.gd")
const ObjectsMovements = preload("res://nodes/motion_engine/modules/objects_move.module.gd")

signal start(motionEngine)

enum motionBody {
	OBJECT2D
	RIGBODY
}

export(NodePath) var rootMotionPath
export(Resource) var motionConfig
export(motionBody) var typeMotionBody
export(bool) var initActive = true

var _objectMovement

var _active = true

func getObjectMove():
	return _objectMovement

func getRootMotion():
	return get_node(rootMotionPath)

func setActive(value):
	_active = value
	if _objectMovement != null:
		_objectMovement._active = value
		if value == false:
			_objectMovement._stop()
		else:
			_objectMovement._resume()
	set_physics_process(_active)

func getActive() -> bool:
	return _active

func _ready():
	setActive(initActive)
	
	if motionConfig != null:
			match typeMotionBody:
				motionBody.OBJECT2D:
					_objectMovement = ObjectsMovements.MoveObject2D.new()
				motionBody.RIGBODY:
					_objectMovement = ObjectsMovements.MoveRigiBody.new()
			
			if _objectMovement == null:
				printerr("ERRO - type body or root motion")
				setActive(false)
				return
			
			var rootMotion = get_node(rootMotionPath)
			
			var config = DynamicResource.ResourceDynamic.new(motionConfig, true)
			var _velocity:float
			var _dir:Vector2
			
			if DynamicResource.isRangeValue(config.getValue("velocity")):
				_velocity = DynamicResource.generateRangeValue(config.getValue("velocity"), DynamicResource.TypeRand.FLOAT)
			else:
				_velocity = DynamicResource.getValueFromRand(config.getValue("velocity"), DynamicResource.Value.DEFAULT)

			if config.getValue("xFix"):
				_dir.x = config.getValue("direction").x
			
			if config.getValue("yFix"):
				_dir.y = config.getValue("direction").y
			
			randomize()
			if config.getValue("dirRandom"):
				if !config.getValue("xFix"):
					_dir.x = int(rand_range(-1, 1))
				
				if !config.getValue("yFix"):
					_dir.y = int(rand_range(-1, 1))
			
			_objectMovement.config(_dir, _velocity, rootMotion)
			_objectMovement._active = getActive()
			
			if getActive():
				emit_signal("start", self)
				_objectMovement._start()
	else:
		setActive(false)
		printerr("ERRO - No motion config to %s" % self)

func _physics_process(delta):
	_objectMovement._update(delta)
