extends Node2D
class_name Player

onready var attributes = $attributes
onready var player_flags = $player_flags
onready var visibility = $visibility

onready var texture = $texture

var _dirX:int
var _dirY:int

var playerDir = Vector2.ZERO
var playerLastDir = Vector2.ZERO

func _getVectorToInt(x:int, y:int) -> Vector2:
	return Vector2(x, y)

func _movement(delta):
	_dirX = Input.get_action_strength("player_right") - Input.get_action_strength("player_left")
	_dirY = Input.get_action_strength("player_down") - Input.get_action_strength("player_up")
	
	if _getVectorToInt(_dirX, _dirY) != Vector2.ZERO:
		playerLastDir = _getVectorToInt(_dirX, _dirY)
	
	playerDir = _getVectorToInt(_dirX, _dirY)
	
	translate(playerDir.normalized() * attributes.getVelocity() * delta)

func _draw():
	draw_rect(Rect2(visibility.position.x, visibility.position.y, 10, 10), Color.red, true)

func _physics_process(delta):
	if player_flags.getFlagState(player_flags.MOVEMENT):
		_movement(delta)
	
	update()
	
