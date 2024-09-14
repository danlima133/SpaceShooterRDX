extends CollisionBox
class_name HitBox

enum propertyNames {
	HIT_VALUE,
	HIT_CONTINUES,
	TIMER_TO_HIT
}

signal hitEvent(hurtBox)

export(Array, int) var filterHurtBox

export(float) var _hitValue
export(bool) var _hitContinues
export(float) var _timerToHit

func _ready():
	initCollisionBox(self)

func _collisionEnterBox(box):
	if !checkColliders(box.id, filterHurtBox):
		emit_signal("hitEvent", box)
		box.hurt(_hitValue, box)
		if _hitContinues:
			box.createTimerOrActive(self)

func setHit(value):
	_hitValue = value
	updateProperty(propertyNames.HIT_VALUE, _hitValue, self)

func getHit() -> float:
	return _hitValue

func setHitContinues(value):
	_hitContinues = value
	updateProperty(propertyNames.HIT_CONTINUES, _hitContinues, self)

func getHitContinues() -> bool:
	return _hitContinues

func setTimerHit(value):
	_timerToHit = value
	updateProperty(propertyNames.TIMER_TO_HIT, _timerToHit, self)

func getTimerHit() -> float:
	return _timerToHit
