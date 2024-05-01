extends CollisionBox
class_name HurtBox

signal hurtEvent(hitBox)

enum {
	PLUS,
	SUBTRACT
}

export(float) var _hurtValue
export(float) var _hurtLimit

onready var _hurtMaxValue = _hurtValue

func _ready():
	initCollisionBox(self)

func setHurtLimit(value):
	_hurtLimit = value

func getHurtLimit() -> float:
	return _hurtLimit

func getHurt() -> float:
	return _hurtValue

func hurt(value:float, hitBox, operation:int = SUBTRACT):
	emit_signal("hurtEvent", hitBox)
	
	match operation:
		PLUS:
			_hurtValue += value
		SUBTRACT:
			_hurtValue -= value
	
	_hurtValue = clamp(_hurtValue, _hurtLimit, _hurtMaxValue)
