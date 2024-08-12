extends CollisionBox
class_name TargetBox

enum ActionType {
	ENTER
	EXIT
}

signal action(action, triger, target, type)

export(Array, int) var actionsFillter

var _actionActive = false

func _ready():
	initCollisionBox(self)

func _collisionEnterBox(box):
	if !checkColliders(box.id, actionsFillter):
		emit_signal("action", box.action, box, self, ActionType.ENTER)
		_actionActive = true

func _collisionExitBox(box):
	if !checkColliders(box.id, actionsFillter):
		emit_signal("action", box.action, box, self, ActionType.EXIT)
		_actionActive = false

func getActionActive() -> bool:
	return _actionActive
