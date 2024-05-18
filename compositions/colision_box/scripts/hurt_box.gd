extends CollisionBox
class_name HurtBox

enum propertyNames {
	HURT_VALUE,
	HURT_LIMIT,
	HURT_MAX
}

signal hurtEvent(hurtBox)
signal hurtNoValue(hurtBox)

enum {
	PLUS,
	SUBTRACT
}

export(float) var _hurtValue
export(float) var _hurtLimit

var _hurtMaxValue = _hurtValue

var timer:Timer

func _ready():
	initCollisionBox(self)

func _collisionExitBox(box):
	if timer != null:
		timer.stop()

func _hurtOnTime(hitBox):
	if hitBox.getHitContinues():
		hurt(hitBox._hitValue)
		timer.start()
	else:
		timer.stop()

func createTimerOrActive(hitBox):
	if timer == null:
		timer = Timer.new()
		timer.one_shot = true
		timer.wait_time = hitBox._timerToHit
		timer.connect("timeout", self, "_hurtOnTime", [ hitBox ])
		add_child(timer)
		timer.start()
	else:
		timer.wait_time = hitBox._timerToHit
		timer.start()

func setHurtLimit(value):
	_hurtLimit = value
	updateProperty(propertyNames.HURT_LIMIT, _hurtLimit, self)

func getHurtLimit() -> float:
	return _hurtLimit

func setHurtMax(value, updateHurt = false):
	_hurtMaxValue = value
	if updateHurt: _hurtValue = _hurtMaxValue
	updateProperty(propertyNames.HURT_MAX, _hurtMaxValue, self)
	
func getHurtMax():
	return _hurtMaxValue

func getHurt() -> float:
	return _hurtValue

func hurt(value:float, operation:int = SUBTRACT):
	match operation:
		PLUS:
			_hurtValue += value
		SUBTRACT:
			_hurtValue -= value
	
	_hurtValue = clamp(_hurtValue, _hurtLimit, _hurtMaxValue)
	
	emit_signal("hurtEvent", self)
	
	if _hurtValue <= _hurtLimit:
		emit_signal("hurtNoValue", self)
