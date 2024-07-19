extends Componet

export var _velocity:int
export var _damage:int

func setVelocity(value:int):
	_velocity = value

func getVelocity() -> int:
	return _velocity

func setDamage(value:int):
	_damage = value

func getDamage() -> int:
	return _damage
