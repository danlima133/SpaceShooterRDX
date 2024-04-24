extends Node2D

onready var player = $PlayerShip1Orange

func _input(event):
	return
	if event is InputEventKey:
		if event.scancode == KEY_ESCAPE and event.pressed:
			OS.window_maximized = false
			OS.window_fullscreen = !OS.window_fullscreen
		elif event.scancode == KEY_F11 and event.pressed:
			OS.window_fullscreen = false
			OS.window_maximized = !OS.window_maximized

func _ready():
	#get_viewport().transparent_bg = true
	#OS.window_fullscreen = true
	
	print(OS.window_size)
	#player.global_position.x = (OS.window_size.x/2)
