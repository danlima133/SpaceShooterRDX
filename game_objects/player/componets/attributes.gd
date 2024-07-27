extends Componet

onready var hurtBox = $"../../hurt_box"

export var _velocity:int
export var _damage:int
export var _resistence:int

func _init_componet():
	hurtBox.setHurtMax(_resistence, true)

func setVelocity(value:int):
	_velocity = value

func getVelocity() -> int:
	return _velocity

func setDamage(value:int):
	_damage = value

func getDamage() -> int:
	return _damage

func setResistence(value:int):
	_resistence = value

func getResistence() -> int:
	return _resistence
