extends Node2D

var level_time:Componet
var player_bounds:Componet
var level_data:LevelData

onready var time_level = $hud/margin/VBoxContainer/HBoxContainer/time_level
onready var score = $hud/margin/VBoxContainer/HBoxContainer/score
onready var star_bronze = $hud/margin/VBoxContainer/star_bronze
onready var star_silvier = $hud/margin/VBoxContainer/star_silvier
onready var star_gold = $hud/margin/VBoxContainer/star_gold

func _on_event_meteors_eventStart(event):
	if level_time != null:
		var timeline = level_time.get_timeline()
		timeline.add_tag("meteor flame", level_time.get_time())

func _on_ManagerComponets_MangerComponetsInitialize(componetsInit, manager:ManagerComponets):
	level_time = manager.getComponet(98)
	level_data = manager.getComponet(23)

func _process(delta):
	var time = level_time.get_time().time()
	time[0] = int(time[0])
	time_level.text = "%s:%s" % [time[1], time[0]]
	
	if player_bounds != null:
		if player_bounds.getWarning():
			get_tree().quit()

func _on_level_data_set_value(scope, token, value):
	match token:
		level_data.Refs.Token.BRONZE:
			star_bronze.get_node("value").text = str(value)
		level_data.Refs.Token.SILVIER:
			star_silvier.get_node("value").text = str(value)
		level_data.Refs.Token.GOLD:
			star_gold.get_node("value").text = str(value)
		level_data.Refs.Token.SCORE:
			score.text = str(value)

func _on_ManagerComponets_MangerComponetsInitialize_player(componetsInit, manager:ManagerComponets):
	player_bounds = manager.getComponet(2)
	
