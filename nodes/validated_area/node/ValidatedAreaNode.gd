extends Node
class_name ValidatedArea, "res://nodes/validated_area/icon/node.png"

var _safe_area:Rect2

var _max_values_x:Array
var _max_values_y:Array

func set_safe_area(safe_area):
	_safe_area = safe_area
	
	_max_values_x = [_safe_area.position.x, _safe_area.size.x + _safe_area.position.x]
	_max_values_y = [_safe_area.position.y, _safe_area.size.y + _safe_area.position.y]

func bind_position_with_area(position, radius):
	var position_x = clamp(position.x, _max_values_x[0] - radius, _max_values_x[1] + radius)
	var position_y = clamp(position.y, _max_values_y[0] - radius, _max_values_y[1] + radius)
	return Vector2(position_x, position_y)

func is_valid_position(position, radius):
	var bind_position = bind_position_with_area(position, radius)
	
	var _max_values_x_with_radius = [_max_values_x[0] - radius, _max_values_x[1] + radius]
	var _max_values_y_with_raiuds = [_max_values_y[0] - radius, _max_values_y[1] + radius]
	
	if bind_position.x in _max_values_x_with_radius:
		return false
	elif bind_position.y in _max_values_y_with_raiuds:
		return false
	return true
