extends Node2D
class_name Player

onready var manager_componets = $manager_componets

onready var visibility = $visibility
onready var texture = $texture

var _dirX:int
var _dirY:int

var playerDir = Vector2.ZERO
var playerLastDir = Vector2.ZERO

func gameOver(die:String, _data:Dictionary):
	print('player die: ' + die)

func _getVectorToInt(x:int, y:int) -> Vector2:
	return Vector2(x, y)

func _movement(delta):
	_dirX = int(Input.get_action_strength("player_right") - Input.get_action_strength("player_left"))
	_dirY = int(Input.get_action_strength("player_down") - Input.get_action_strength("player_up"))
	
	if _getVectorToInt(_dirX, _dirY) != Vector2.ZERO:
		playerLastDir = _getVectorToInt(_dirX, _dirY)
	
	playerDir = _getVectorToInt(_dirX, _dirY)
	
	translate(playerDir.normalized() * manager_componets.getComponet(0).getVelocity() * delta)

func _draw():
	draw_rect(Rect2(visibility.position.x, visibility.position.y, 10, 10), Color.red, true)

func _physics_process(delta):
	if manager_componets.getComponet(1).getFlagState(manager_componets.getComponet(1).MOVEMENT):
		_movement(delta)
	
	update()
	
