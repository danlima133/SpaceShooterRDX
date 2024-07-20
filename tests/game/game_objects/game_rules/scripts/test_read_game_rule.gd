extends Node

const JsonSolution = preload("res://libs/json_solution.lib.gd")

onready var readRule = $readGameRule

func _ready():
	
	var paths = {
		"json": readRule.getRulesAnvaliable("json"),
		"ini": readRule.getRulesAnvaliable("ini"),
		"xml": readRule.getRulesAnvaliable("xml")
	}
	
	var ruleJson = readRule.getRule(readRule.RuleJson, paths["json"]["game_rule"])
	var contentJson = ruleJson.content
	print(contentJson)
	
	print("\n")
	
	var ruleIni = readRule.getRule(readRule.RuleIni, paths["ini"]["game_rule"])
	var contentIni = ruleIni.content
	print(contentIni)

	print("\n")

	var ruleXml = readRule.getRule(readRule.RuleXml, paths["xml"]["game_rule"])
	var contentXml = ruleXml.content
	
	var solutionData = JsonSolution.JsonSolution.new(contentXml)
	var solution = solutionData.getSolution()
	print(solution)
