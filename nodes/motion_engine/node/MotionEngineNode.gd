extends Node
class_name MotionEngine, "res://nodes/motion_engine/icon/node.png"

const DynamicResource = preload("res://libs/resource_dynamic.lib.gd")

signal start(motionEngine)

enum motionBody {
	OBJECT2D
	RIGBODY
}

export(NodePath) var rootMotionPath
export(Resource) var motionConfig
export(motionBody) var typeMotionBody
export(bool) var initActive = true

var _objectMovement:Move

var _active = true

class Move:
	signal event(event, data)
	
	var _dir:Vector2
	var _velocity:float
	
	var _active:bool
	
	var _rootMotion:Object 
	
	func _start():
		pass
	
	func _update(delta:float):
		pass
	
	func _pause():
		pass
	
	func _resume():
		pass
	
	func config(dir:Vector2, velocity:float, rootMotion:Object):
		_dir = dir
		_velocity = velocity
		_rootMotion = rootMotion
	
	func event(nameEvent:String, data:Dictionary = {}):
		emit_signal("event", nameEvent, data)
	
	func setDir(dir:Vector2):
		_dir = dir
	
	func getRootMotion() -> Object:
		return _rootMotion
	
	func getActive() -> bool:
		return _active
	
	func getVelocity() -> float:
		return _velocity
	
	func getDir() -> Vector2:
		return _dir

class MoveObject2D extends Move:
	
	func _start():
		event("test", {"start": true})
	
	func _update(delta:float):
		getRootMotion().translate(getDir() * getVelocity() * delta)

class MoveRigiBody extends Move:
	func move():
		if getActive():
			getRootMotion().add_force(getRootMotion().global_position, Vector2(getVelocity() * getDir().x, getVelocity() * getDir().y))
			event("motionBody")
		else:
			event("motionPaused")

func getObjectMove() -> Move:
	return _objectMovement

func getRootMotion() -> Node2D:
	return get_node(rootMotionPath) as Node2D

func setActive(value):
	_active = value
	if _objectMovement != null:
		_objectMovement._active = value
		if value == true:
			_objectMovement._pause()
		else:
			_objectMovement._resume()
	set_physics_process(_active)

func getActive() -> bool:
	return _active

func _ready():
	setActive(initActive)
	
	if motionConfig != null:
		if getActive():
			match typeMotionBody:
				motionBody.OBJECT2D:
					_objectMovement = MoveObject2D.new()
				motionBody.RIGBODY:
					_objectMovement = MoveRigiBody.new()
			
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
			
			emit_signal("start", self)
			_objectMovement._start()
	else:
		setActive(false)
		printerr("ERRO - No motion config to %s" % self)

func _physics_process(delta):
	_objectMovement._update(delta)
