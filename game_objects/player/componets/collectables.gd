extends Componet

func _on_target_box_action(action, triger:CollisionBox, target:TargetBox, type):
	if type == target.ActionType.ENTER:
		if action == "get_star":
			var root = triger.get_parent()
			var improvement = root.get_node("ManagerComponets").getComponet(0)
			match improvement.getStar():
				improvement.Star.BRONZE:
					print("get star broze")
				improvement.Star.SILVIER:
					print("get star silvier")
				improvement.Star.GOLD:
					print("get star gold")
			root.get_node("ObjectManager")._reset()
