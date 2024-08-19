extends Node2D

const RegularMath = preload("res://libs/regular_math.lib.gd")

var rectsWolrd = []

var rectsTest = [
	Rect2(10, 30, 50, 80),
	Rect2(-20, 60, 20, 50),
	Rect2(45, 90, 70, 35),
	Rect2(140, 20, 50, 20),
	Rect2(-40, 25, 30, 30),
	Rect2(34, 30, 45, 40)
]

func _draw():
	for rectW in rectsWolrd:
		draw_rect(rectW, Color.red, false)
		draw_circle(rectW.get_center(), 2, Color.white)
	
	draw_circle(global_position, 10, Color.purple)

func _ready():
#	var rectA = Rect2(376, 0, 30, 30)
#	var rectB = Rect2(377, 0, 30, 30)
#	var rectTest = RegularMath.getSide(rectA, rectB)
#	if rectTest != null:
#		rectsWolrd.append(rectTest)
#	rectsWolrd.append(rectB)
#	print(rectTest)
	for value in range(5):
		randomize()
		var x = value + int(rand_range(100, 200))
		var y = value + int(rand_range(100, 200))
		rectsTest.append(Rect2(x, y, (randi() % 50 + 10), (randi() % 50 + 10)))
#
	for rectT in rectsTest:
		var rect = RegularMath.getRectNoIntersects(rectsWolrd, rectT)
		rectsWolrd.append(rect)
	update()
	print(rectsWolrd)
	
