extends Node

const JsonSolution = preload("res://libs/json_solution.lib.gd")

func _on_manager_componets_MangerComponetsInitialize(componetsInit, manager:ManagerComponets):
	var readRule = manager.getComponet(35)
	
	var paths = {
		"json": readRule._getRulesAnvaliable("json"),
		"ini": readRule._getRulesAnvaliable("ini"),
		"xml": readRule._getRulesAnvaliable("xml")
	}
	
	var ruleJson = readRule.getRule(readRule.RuleJson, paths["json"][0])
	var contentJson = ruleJson.content
	print(contentJson)
	
	print("\n")
	
	var ruleIni = readRule.getRule(readRule.RuleIni, paths["ini"][0])
	var contentIni = ruleIni.content
	print(contentIni)

	print("\n")

	var ruleXml = readRule.getRule(readRule.RuleXml, paths["xml"][0])
	var contentXml = ruleXml.content
	
	var solutionData = JsonSolution.JsonSolution.new(contentXml)
	var solution = solutionData.getSolution()
	print(solution)
