extends Componet

const RegularMath = preload("res://libs/regular_math.lib.gd")

var _seconds:float
var _time = RegularMath.TimeData.new()
var _timeline = Timeline.new("level")

class Timeline:
	signal add_tag(tag_name)
	signal remove_tag(tag_name)
	
	var _tags:Dictionary
	var _timeline_name:String

	func _init(timeline_name:String):
		_timeline_name = timeline_name

	func add_tag(tag_name:String, tag_time, tag_data:Dictionary = {}):
		if not _tags.has(tag_name):
			_tags[tag_time.get_time_in_seconds()] = {
				"tag_name": tag_name,
				"created_at": tag_time.time(),
				"metedata": tag_data
			}
			emit_signal("add_tag", tag_name)
			return OK
		return ERR_ALREADY_EXISTS
	
	func remove_tag(tag_name:String):
		if _tags.has(tag_name):
			_tags.erase(tag_name)
			return OK
			emit_signal("remove_tag", tag_name)
		return ERR_DOES_NOT_EXIST
	
	func get_time() -> Array:
		return _tags.keys()
	
	func get_tags():
		return _tags.values()
	
	func get_timeline_name():
		return _timeline_name

func _process(delta):
	_seconds += delta

func get_time() -> RegularMath.TimeData:
	_time.set_time_by_seconds(_seconds)
	return _time

func get_timeline() -> Timeline:
	return _timeline
