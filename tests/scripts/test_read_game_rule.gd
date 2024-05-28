extends Node

const JsonSolution = preload("res://libs/json_solution.lib.gd")

func _on_manager_componets_MangerComponetsInitialize(componetsInit, manager:ManagerComponets):
	var readRule = manager.getComponet(35)
	var paths = readRule._getRulesAnvaliable("XML")
	var rule = readRule.getRule(readRule.RuleXml, paths[0])
	
	var content = rule.content
	var solution = JsonSolution.JsonSolution.new(content)
	
	var s = solution.getSolution()
	#print(s)
	print(JsonSolution.getTagJsonBySolution(s, "player", "texture")["attributes"]["path"]["list"][2])
	
