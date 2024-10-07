extends Node
class_name CameraSystem, "res://nodes/camera_system/icon/node.png"

const Groups = preload("res://libs/groups.lib.gd")

signal change_camera(camera_name)
signal remove_camera()

const GROUP_CAMERAS = "cameras"

var _manager_groups = Groups.Manager.new()

var _cameras = {}
var _current_camera:Camera2D

func _ready():
	_manager_groups.initManager(self)
	update_cameras()

func update_cameras():
	_cameras = _manager_groups.getMembersInGroup(GROUP_CAMERAS)

func get_cameras() -> Array:
	return _cameras.keys()

func set_current_camera(camera_name):
	if _cameras.has(camera_name):
		var __camera:Camera2D = _cameras[camera_name].getOutputObject()
		_current_camera = __camera
		__camera.current = true
		emit_signal("change_camera", camera_name)
		return OK
	return ERR_INVALID_DATA

func remove_current_camera():
	if _current_camera != null:
		_current_camera.current = false
		_current_camera = null
		emit_signal("remove_camera")
		return OK
	return ERR_DOES_NOT_EXIST


