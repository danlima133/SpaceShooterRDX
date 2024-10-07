extends Node

onready var camera_system = $CameraSystem

var _idx_camera = 0

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_UP:
					_idx_camera += 1
				KEY_DOWN:
					_idx_camera -= 1
				KEY_R:
					camera_system.remove_current_camera()
			if event.scancode == KEY_UP or event.scancode == KEY_DOWN:
				_idx_camera = clamp(_idx_camera, 0, 2)
				change_camera(_idx_camera)

func change_camera(idx):
	var _cameras = camera_system.get_cameras()
	camera_system.set_current_camera(_cameras[idx])

func remove_camera():
	camera_system.remove_current_camera()

func _on_CameraSystem_change_camera(camera_name):
	print(camera_name)

func _on_CameraSystem_remove_camera():
	print("remove current camera")
