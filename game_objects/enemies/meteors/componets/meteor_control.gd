extends Componet

const fragamentsBrown = "res://assets/meteors/fragaments/"

onready var texture = $"../../texture"
onready var motion_engine = $"../../MotionEngine"

onready var hurt_box = $"../../hurt_box"
onready var hit_box = $"../../hit_box"

onready var readGameRule = $"../../readGameRule"

var _currentData:Dictionary

var meteorsData:Dictionary
var treshold_shape:float

func _init_componet():
	var rulesAnvaliable = readGameRule.getRulesAnvaliable("json")
	var rule = readGameRule.getRule(readGameRule.RuleJson, rulesAnvaliable["meteors_rule"])
	
	meteorsData = rule.content
	treshold_shape = meteorsData["configs"]["treshold_shape"]

func setMeteor(meteor:Dictionary = {}):
	randomize()
	
	var meteorData:Dictionary

	var meteorIndex = (randi() % meteorsData["meteors"].size())
	
	if meteor.empty():
		meteorData = meteorsData["meteors"][meteorIndex]
	else: meteorData = meteor
	
	_currentData = meteorData
	
	var pathImage = "res://assets/sprites/meteors/%s.png" % meteorData["image"]
	
	texture.texture = load(pathImage)
	
	var shape = CircleShape2D.new()
	shape.radius = (texture.texture.get_width()/2) - treshold_shape
	
	hurt_box.get_node("hurt_shape").set_deferred("shape", shape)
	hit_box.get_node("hit_shape").set_deferred("shape", shape)
	
	hurt_box.setHurtMax(meteorData["resistence"], true)
	hit_box.setHit(meteorData["damage"])
	
	var velocity:float
	
	if meteorData["velocity"].size() == 2:
		velocity = rand_range(meteorData["velocity"][0], meteorData["velocity"][1])
	else:
		velocity = meteorData["velocity"][0]
	
	motion_engine.setVelocity(velocity)

func getFragmets(height:int, count:Array, type:String) -> Array:
	randomize()
	
	var fragaments = []
	var indexs:int
	
	if count.size() == 2:
		indexs = rand_range(count[0], count[1])
	else:
		indexs = count[0]
	
	for index in range(indexs):
		randomize()
		
		var factor = (randi() % height) + 1
		var value = height % factor
		
		if value == 0:
			var meteorIndex = randi() % meteorsData["meteors_small"][type].size()
			fragaments.append(meteorsData["meteors_small"][type][meteorIndex])
			continue
			
		var meteorIndex = randi() % meteorsData["meteors_high"][type].size()
		fragaments.append(meteorsData["meteors_high"][type][meteorIndex])
	
	return fragaments

func getMeteorData(image:Texture, resistence:int, damage:int, height = 1, fragamentsCount = 1):
	return {
		"image": image,
		"resistence": resistence,
		"damage": damage
	}

func getCurrentData() -> Dictionary:
	return _currentData
