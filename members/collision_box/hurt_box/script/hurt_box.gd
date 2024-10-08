extends CollisionBox
class_name HurtBox

enum propertyNames {
	HURT_VALUE,
	HURT_LIMIT,
	HURT_MAX
}

signal hurtEvent(hitBox)
signal hurtNoValue(hittBox)

enum {
	PLUS,
	SUBTRACT
}

export(float) var _hurtValue
export(float) var _hurtLimit

onready var _hurtMaxValue = _hurtValue

var timer:Timer

func _ready():
	initCollisionBox(self)

func _collisionExitBox(box):
	if timer != null:
		timer.stop()

func _hurtOnTime(hitBox):
	if hitBox.getHitContinues():
		hurt(hitBox._hitValue, null)
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

func hurt(value:float, box:CollisionBox, operation:int = SUBTRACT):
	if value == -1:
		_hurtValue = 0
	else:
		match operation:
			PLUS:
				_hurtValue += value
			SUBTRACT:
				_hurtValue -= value
		
		_hurtValue = clamp(_hurtValue, _hurtLimit, _hurtMaxValue)
	
	emit_signal("hurtEvent", box)
	
	if _hurtValue <= _hurtLimit:
		emit_signal("hurtNoValue", box)
