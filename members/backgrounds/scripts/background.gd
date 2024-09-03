tool
extends Node2D

enum BackgroundVariations {
	BLUE
	GREEN
	PURPLE
}

const _rootPath = "res://assets/backgrounds/"
const _imageType = ".png"

const groupBackgrounds = {
	BackgroundVariations.BLUE: "blue_nebula",
	BackgroundVariations.GREEN: "green_nebula",
	BackgroundVariations.PURPLE: "purple_nebula"
}

export(BackgroundVariations) var backgroundType setget _setType
export(Dictionary) var configBackground setget _setConfig

onready var texture = $texture

func _setType(new_value):
	backgroundType = new_value
	if Engine.editor_hint:
		get_node("texture").texture = _getBackgroundByConfig(backgroundType, configBackground)

func _setConfig(new_value):
	configBackground = new_value
	if Engine.editor_hint:
		get_node("texture").texture = _getBackgroundByConfig(backgroundType, configBackground)

func _getImageByPath(path:String, imageDefault:Texture = null) -> Texture:
	if ResourceLoader.exists(path):
		return ResourceLoader.load(path) as Texture
	return imageDefault

func _getBackgroundByConfig(group:int, config:Dictionary = {}) -> Texture:
	randomize()
	
	var pathFile = _rootPath + groupBackgrounds[group] + "/"
	
	var isRandom = config.get("random", true)
	
	if isRandom:
		var randomValue = randi() % 8
		pathFile += str(randomValue) + _imageType
		return _getImageByPath(pathFile, null)
	else:
		pathFile += str(config["imageIdx"]) + _imageType
		return _getImageByPath(pathFile, null)
	return null

func _ready():
	texture.texture = _getBackgroundByConfig(backgroundType, configBackground)
