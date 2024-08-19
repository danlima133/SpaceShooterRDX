extends Script

class Move:
	signal event(event, data)
	
	var _dir:Vector2
	var _targetDir:Vector2
	var _velocity:float
	var _targetVelocity:float
	
	var _active:bool
	
	var _rootMotion:Object 
	
	func _config():
		pass
	
	func _start():
		pass
	
	func _update(delta:float):
		pass
	
	func _stop():
		pass
	
	func _resume():
		pass
	
	func config(dir:Vector2, velocity:float, rootMotion:Object):
		_dir = dir
		_targetDir = dir
		_velocity = velocity
		_targetVelocity = velocity
		_rootMotion = rootMotion
		_config()
	
	func event(nameEvent:String, data:Dictionary = {}):
		emit_signal("event", nameEvent, data)
	
	func setDir(dir:Vector2):
		_dir = dir
	
	func getDir(dirTarget:bool = true) -> Vector2:
		return _targetDir if dirTarget else _dir
	
	func setVelocity(velocity:float):
		_velocity = velocity
	
	func getVelocity(velocityTarget:bool = true) -> float:
		return _targetVelocity if velocityTarget else _velocity
	
	func getRootMotion() -> Object:
		return _rootMotion
	
	func getActive() -> bool:
		return _active

class MoveObject2D extends Move:
	
	func _start():
		event("test", {"start": true})
	
	func _update(delta:float):
		getRootMotion().translate(getDir() * getVelocity() * delta)

class MoveRigiBody extends Move:
	func move(dirTarget:bool = true, velocityTarget:bool = true):
		if getActive():
			var direction = getDir(dirTarget)
			var velocity = getVelocity(velocityTarget)

			getRootMotion().add_force(getRootMotion().global_position, Vector2(velocity * direction.x, velocity * direction.y))
			event("motionBody")
		else:
			event("motionPaused")
	
	func impulse(dirTarget:bool = true, impulse:float = getVelocity()):
		if getActive():
			var direction = getDir(dirTarget)
			getRootMotion().apply_impulse(getRootMotion().global_position, Vector2(impulse * direction.x, impulse * direction.y))
			event("motionBody")
		else:
			event("motionPaused")
	
	func _config():
		getRootMotion().can_sleep = false
		getRootMotion().connect("body_entered", self, "_bodyEntered")
		getRootMotion().connect("body_exited", self, "_bodyExited")
	
	func _start():
		move()
	
	func _stop():
		getRootMotion().sleeping = true
	
	func _resume():
		getRootMotion().sleeping = false
	
	func _bodyEntered(body):
		body.apply_impulse(body.global_position, Vector2(80 * getDir(false).x, 80 * getDir(false).y))
		event("collideEnter", { "collider": body, "collisor": getRootMotion() })
	
	func _bodyExited(body):
		event("collideExit", { "collider": body, "collisor": getRootMotion() })
