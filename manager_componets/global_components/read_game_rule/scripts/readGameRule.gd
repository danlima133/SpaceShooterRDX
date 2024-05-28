extends Componet

class Rule:
	var ruleName:String
	var ruleType:String
	var content
	
	func _init(ruleName:String, ruleType:String, content):
		self.ruleName = ruleName
		self.ruleType = ruleType
		self.content = content

class RuleInterface:
	static func _read(path:String):
		pass

class RuleJson extends RuleInterface:
	static func _read(path:String):
		var ruleData = Rule.new(path.get_file(), "JSON", {false: 1, true: 10})
		return ruleData

class RuleXml extends RuleInterface:
	static func _read(path:String):
		var xml = XMLParser.new()
		xml.open(path)
		
		var ruleData = Rule.new(path.get_file(), "XML", xml)
		return ruleData

const rulesPaths = {
	"JSON": "res://game_rules/json/",
	"XML": "res://game_rules/xml/"
}

export var Rules = {}

func _getRulesAnvaliable(typeRule:String = "JSON"):
	var files = []
	typeRule = typeRule.to_upper()
	
	var cursor = Directory.new()
	if !(typeRule in rulesPaths.keys()):
		print(rulesPaths.keys())
		return ERR_INVALID_PARAMETER
	var path = rulesPaths[typeRule]
	if cursor.dir_exists(path):
		cursor.open(path)
		cursor.list_dir_begin(true)
		var file = cursor.get_next()
		while file != "":
			files.append(path + file)
			file = cursor.get_next()
	else:
		return ERR_FILE_NOT_FOUND
	
	return files

func getRule(rule, path:String) -> Rule:
	return rule._read(path)

