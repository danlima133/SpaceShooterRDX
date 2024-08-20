extends Node2D

const RegularMath = preload("res://libs/regular_math.lib.gd")

var rects:Array

func _draw():
	for rect in rects:
		draw_rect(rect, Color.red, false)
		draw_circle(rect.get_center(), 5, Color.white)

func _ready():
	var map = RegularMath.RectsMap.Map.new()
	var mapRects = RegularMath.RectsMap.new(map, {
		"axisFix": true
	})

	map.addRect(Rect2(10, 25, 85, 40))
	map.addRect(Rect2(6, 10, 40, 45))

	rects = map.getAllRectsOnMap()
	update()
