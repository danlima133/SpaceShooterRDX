extends CollisionBox
class_name HitBox

signal hitEvent(hitBox)

export(Array, int) var filterHurtBox

export(float) var _hitValue
export(bool) var _hitContinues
export(float) var _timerToHit

var timer:Timer

func _ready():
	initCollisionBox(self)

func _collisionEnterBox(box):
	if !checkColliders(box.id, filterHurtBox):
		emit_signal("hitEvent", self)
		box.hurt(_hitValue)
		emit_signal("hitEvent", self)
		if _hitContinues:
			_createTimerOrActive([ box ])

func _collisionExitBox(box):
	if timer != null:
		timer.stop()

func _hitOnTime(box):
	emit_signal("hitEvent", self)
	box.hurt(_hitValue)
	timer.start()

func _createTimerOrActive(args):
	if timer == null:
		timer = Timer.new()
		timer.one_shot = true
		timer.wait_time = _timerToHit
		var erro = timer.connect("timeout", self, "_hitOnTime", [ args[0] ])
		add_child(timer)
		timer.start()
	else:
		timer.start()

func checkColliders(idCollider:int, groupCollider:Array):
	return (idCollider in groupCollider)

func setHit(value):
	_hitValue = value

func getHit() -> float:
	return _hitValue

func setHitContinues(value):
	_hitContinues = value

func getHitContinues() -> bool:
	return _hitContinues

func setTimerHit(value):
	_timerToHit = value

func getTimerHit() -> float:
	return _timerToHit
