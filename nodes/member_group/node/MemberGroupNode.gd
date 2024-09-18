extends Node
class_name MemberGroup, "res://nodes/member_group/icon/node.png"

export(String) var _tag = "None"

func getOutputObject() -> Object:
	return get_parent()

func getTag() -> String:
	return _tag
