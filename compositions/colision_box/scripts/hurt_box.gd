extends CollisionBox
class_name HurtBox

signal hurtEvent(hurtBox)
signal hurtNoValue(hurtBox)

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

func setHurtMax(value):
	_hurtMaxValue = value

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
