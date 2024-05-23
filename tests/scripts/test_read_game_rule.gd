extends Node

func _on_manager_componets_MangerComponetsInitialize(componetsInit, manager:ManagerComponets):
	var readRule = manager.getComponet(35)
	var paths = readRule._getRulesAnvaliable("JSON")
	var rule = readRule.getRule(readRule.RuleXml, paths[2])
	print(rule.content)
	
