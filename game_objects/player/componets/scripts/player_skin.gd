extends Componet

export(Texture) var spriteDefault

const rootPathSprites = "res://assets/sprites/player/"

onready var texture = $"../../texture"

func getSkinByLevel(level:int, variation:String) -> Texture:
	var path = (rootPathSprites + "nvl_" + str(level) + "/" + variation.to_upper() + ".png")
	
	if ResourceLoader.exists(path):
		return ResourceLoader.load(path) as Texture
	
	return spriteDefault

func _init_componet():
	texture.texture = getSkinByLevel(3, "d")
