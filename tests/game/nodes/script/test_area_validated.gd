extends Node2D

onready var validated_area = $ValidatedArea

var _safe_area = Rect2(300, 200, 200, 200)
var _radius = 10

var _position_test:Vector2

func _ready():
	validated_area.set_safe_area(_safe_area)

func _draw():
	draw_rect(_safe_area, Color.red, false)
	draw_circle(_position_test, _radius, Color.blue)

func _process(delta):
	_position_test = validated_area.bind_position_with_area(get_global_mouse_position(), _radius)
	print(validated_area.is_valid_position(get_global_mouse_position(), _radius))
	update()
