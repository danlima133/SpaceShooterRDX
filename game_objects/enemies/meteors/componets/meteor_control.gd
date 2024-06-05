extends Componet

const fragamentsBrown = "res://assets/meteors/fragaments/"

onready var texture = $"../../texture"

onready var hurt_box = $"../../hurt_box"
onready var hit_box = $"../../hit_box"

var _currentData:Dictionary

export(Dictionary) var data = {
	"meteor_base": [],
	"treshold_shape": 0
}

func setMeteor(meteor:Dictionary = {}):
	randomize()
	
	var meteorData:Dictionary
	
	var meteorsCount = data.meteor_base.size()
	var meteorIndex = (randi() % meteorsCount)
	
	if meteor.empty():
		meteorData = data.meteor_base[meteorIndex]
	else: meteorData = meteor
	
	_currentData = meteorData
	
	texture.texture = meteorData["image"]
	
	var shape = CircleShape2D.new()
	shape.radius = (texture.texture.get_width()/2) - data.treshold_shape
	
	hurt_box.get_node("hurt_shape").shape = shape
	hit_box.get_node("hit_shape").shape = shape
	
	hurt_box.setHurtMax(meteorData["resistence"], true)
	hit_box.setHit(meteorData["damage"])

func getFragamets(height:int, count:int) -> Array:
	var fragaments = []
	
	for index in range(count):
		randomize()
		
		var factor = (randi() % height) + 1
		var value = height % factor
		
		if value == 0:
			fragaments.append(getMeteorData(
				load("res://assets/sprites/meteors/brown/fragaments/low/0.png"), 1, 1, 1, 0))
			continue
		fragaments.append("high")
	
	return fragaments

func getMeteorData(image:Texture, resistence:int, damage:int, height = 1, fragamentsCount = 1):
	return {
		"image": image,
		"resistence": resistence,
		"damage": damage
	}

func getCurrentData() -> Dictionary:
	return _currentData
