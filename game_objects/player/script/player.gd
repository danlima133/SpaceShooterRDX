extends Node2D
class_name Player

onready var manager_componets = $manager_componets

onready var visibility = $visibility
onready var texture = $texture

var _dirX:int
var _dirY:int

var playerDir = Vector2.ZERO
var playerLastDir = Vector2.ZERO

var attributes:Componet
var player_flgas:Componet

func _input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_T:
			var objects = $object_pooling.spaw({
				"group": "powerUps",
				"count": 1
			})
			print(objects)
		
		if event.pressed and event.scancode == KEY_Y:
			var objects = $object_pooling.spaw({
				"group": "bullets",
				"count": 1
			}, { "position": global_position })
			print(objects)

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
	
	translate(playerDir.normalized() * attributes.getVelocity() * delta)

func _draw():
	draw_rect(Rect2(visibility.position.x + (-5), visibility.position.y + (-5), 10, 10), Color.red, true)

func _physics_process(delta):
	if player_flgas.getFlagState(player_flgas.MOVEMENT):
		_movement(delta)
	
	update()
	
	if get_parent().has_node("debug"):
		get_parent().get_node("debug").text = "warning = " + str(manager_componets.getComponet(2).getWarning())
	
func _on_manager_componets_MangerComponetsInitialize(componetsInit:int, manager:ManagerComponets):
	attributes = manager.getComponet(0)
	player_flgas = manager.getComponet(1)
