extends Node2D
class_name Player

const Groups = preload("res://libs/groups.lib.gd")

onready var texture = $texture

var _dirX:int
var _dirY:int
var _radius:float = 3

var playerDir = Vector2.ZERO
var playerLastDir = Vector2.ZERO

var attributes:Componet
var player_flgas:Componet

func gameOver(die:String, data:Dictionary = {}):
	if player_flgas.getFlagState("game_over"):
		var manager = Groups.Manager.new()
		manager.initManager(self)
		if manager.hasTagOnGroup("level", "data"):
			var member = manager.getMemberWithTag("level", "data") as MemberGroup
			var level_data = member.getOutputObject() as LevelData
			print(level_data.export_data())
		queue_free()

func _getVectorToInt(x:int, y:int) -> Vector2:
	return Vector2(x, y)

func _movement(delta):
	_dirX = int(Input.get_action_strength("player_right") - Input.get_action_strength("player_left"))
	_dirY = int(Input.get_action_strength("player_down") - Input.get_action_strength("player_up"))

	if _getVectorToInt(_dirX, _dirY) != Vector2.ZERO:
		playerLastDir = _getVectorToInt(_dirX, _dirY)

	playerDir = _getVectorToInt(_dirX, _dirY)
	
	translate(playerDir.normalized() * attributes.getVelocity() * delta)

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
