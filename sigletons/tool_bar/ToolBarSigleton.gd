extends Node

var _toolBarActive = true
var _pressed = false

func setToolBar(value):
	_toolBarActive = value

func getToolBarActive() -> bool:
	return _toolBarActive

func _process_tool_bar(keyCode:int):
	if _toolBarActive:
		match keyCode:
			KEY_F11:
				OS.window_fullscreen = !OS.window_fullscreen
			KEY_F1:
				print("close game")

func _input(event):
	if event is InputEventKey:
		if event.pressed and !_pressed:
			_pressed = true
			_process_tool_bar(event.scancode)
		elif !event.pressed:
			!event.pressed
			_pressed = false
