extends Node2D
class_name Player

onready var visibility = $visibility
onready var texture = $texture
onready var hurt_box = $hurt_box
onready var shoot_point = $shoot_point

var _friction:float = 0.3
var _dirX:int
var _dirY:int

var _rotate:float
var _positionTarget:Vector2
var _angleSmooth:float = 0.3

var playerDir = Vector2.ZERO
var playerLastDir = Vector2.ZERO

var attributes:Componet
var player_flgas:Componet

func gameOver(die:String, data:Dictionary = {}):
	if player_flgas.getFlagState("game_over"):
		print('player die: ' + die)
		queue_free()

func _getVectorToInt(x:int, y:int) -> Vector2:
	return Vector2(x, y)

func _movement(delta):
	_positionTarget = get_global_mouse_position()
	_rotate = global_position.angle_to_point(_positionTarget) + PI
	rotation = lerp_angle(rotation, _rotate, _angleSmooth)
	
	_dirX = int(Input.get_action_strength("player_right") - Input.get_action_strength("player_left"))
	_dirY = int(Input.get_action_strength("player_down") - Input.get_action_strength("player_up"))

	if _getVectorToInt(_dirX, _dirY) != Vector2.ZERO:
		playerLastDir = _getVectorToInt(_dirX, _dirY)
		playerDir = _getVectorToInt(_dirX, _dirY)
		playerDir = playerDir.normalized()
	else:
		playerDir = lerp(playerDir, Vector2.ZERO, _friction)
	
	translate(playerDir * attributes.getVelocity() * delta)

func _draw():
	draw_rect(Rect2(visibility.position.x + (-5), visibility.position.y + (-5), 10, 10), Color.red, true)

func _ready():
	if player_flgas.getFlagState("movement"):
		shoot_point.position = Vector2(43, 0)
		texture.rotation_degrees = 90
		hurt_box.rotation_degrees = 90

func _process(delta):
	update()

func _physics_process(delta):
	if player_flgas.getFlagState("movement"):
		_movement(delta)
	
func _on_ManagerComponets_MangerComponetsInitialize(componetsInit, manager):
	attributes = manager.getComponet(0)
	player_flgas = manager.getComponet(1)

# ---------- block is test ----------
func _on_hurt_box_hurtNoValue(hurtBox):
	gameOver("by ship")
# --------------- end --------------
