extends Node

class Manager extends Node:
	class GroupMap:
		var _map:Dictionary
		
		func setMapToGroup(nodes:Array, group:String):
			if _map.has(group): return ERR_ALREADY_EXISTS
			if nodes.size() == 0: return ERR_CANT_CREATE
			_map[group] = {}
			for node in nodes:
				if not node is MemberGroup:
					printerr("Err - group not valid")
					_map.erase(group)
					return ERR_INVALID_DATA
				_map[group][node.getTag()] = node
			return OK
		
		func getMap() -> Dictionary:
			return _map

	var _init = false
	var map = GroupMap.new()

	func initManager(root:Object):
		if not _init:
			root.add_child(self)
			_init = true
			return OK
		return FAILED

	func getMembersInGroup(group:String):
		if _init:
			var err = _setGroupOnMap(group)
			if err == ERR_CANT_CREATE or err == ERR_INVALID_DATA: return ERR_CANT_RESOLVE
			return map.getMap().get(group)
		return ERR_UNAVAILABLE

	func getMemberWithTag(group:String, tag:String):
		if _init:
			var err = _setGroupOnMap(group)
			if err == ERR_INVALID_DATA: return ERR_CANT_RESOLVE
			var groupMap = map.getMap().get(group, {}) as Dictionary
			var node = groupMap.get(tag)
			if node != null: return node
			else: return ERR_INVALID_PARAMETER
		return ERR_UNAVAILABLE
	
	func hasGroup(group:String) -> bool:
		if _init:
			var err = _setGroupOnMap(group)
			if err == ERR_INVALID_DATA: return false
			return map.getMap().has(group)
		return false
	
	func hasTagOnGroup(group:String, tag:String):
		if _init:
			if not hasGroup(group): return false
			_setGroupOnMap(group)
			if map.getMap().has(group) == true:
				if map.getMap()[group].get(tag) != null:
					return true
		return false
	
	func _setGroupOnMap(groupName:String) -> int:
		var members = get_tree().get_nodes_in_group(groupName)
		return map.setMapToGroup(members, groupName)
