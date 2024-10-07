extends Componet

const Groups = preload("res://libs/groups.lib.gd")

var _manager = Groups.Manager.new()

func _init_componet():
	_manager.initManager(self)

func _on_target_box_action(action, triger:CollisionBox, target:TargetBox, type):
	if type == target.ActionType.ENTER:
		if action == "get_star":
			var root = triger.get_parent()
			var improvement = root.get_node("ManagerComponets").getComponet(0)
			if _manager.hasTagOnGroup("level", "data"):
				var member = _manager.getMemberWithTag("level", "data") as MemberGroup
				var level_data = member.getOutputObject() as LevelData
				match improvement.getStar():
					improvement.Star.BRONZE:
						level_data.set_value(level_data.Refs.Scope.STARS, level_data.Refs.Token.BRONZE, 1, true)
					improvement.Star.SILVIER:
						level_data.set_value(level_data.Refs.Scope.STARS, level_data.Refs.Token.SILVIER, 1, true)
					improvement.Star.GOLD:
						level_data.set_value(level_data.Refs.Scope.STARS, level_data.Refs.Token.GOLD, 1, true)
			root.get_node("ObjectManager")._reset()
