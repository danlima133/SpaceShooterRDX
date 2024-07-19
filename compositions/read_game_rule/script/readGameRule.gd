extends Node

class Rule:
	var ruleName:String
	var ruleType:String
	var err:int
	var content
	
	func _init(ruleName:String = "", ruleType:String = "", content = null, err = OK):
		self.ruleName = ruleName
		self.ruleType = ruleType
		self.content = content
		self.err = err
	
	func setErro(err:int):
		self.err = err

class RuleInterface:
	static func _read(path:String):
		pass

class RuleJson extends RuleInterface:
	static func _read(path:String):
		var file = File.new()
		var json:String
		
		var ruleData:Rule
		var parse:JSONParseResult
		
		if file.file_exists(path):
			file.open(path, File.READ)
			json = file.get_as_text()
			
			parse = JSON.parse(json)
			if parse.error == OK:
				ruleData = Rule.new(path.get_file(), "JSON", parse.result)
			else:
				ruleData = Rule.new()
				ruleData.setErro(ERR_PARSE_ERROR)
				printerr("parse JSON erro to " + path + " erro " + parse.error_string + " - line: " + str(parse.error_line))
		else:
			ruleData = Rule.new()
			ruleData.setErro(ERR_FILE_BAD_PATH)
		
		return ruleData

class RuleXml extends RuleInterface:
	static func _read(path:String):
		var ruleData:Rule
		var file = File.new()
		
		if file.file_exists(path):
			var xml = XMLParser.new()
			xml.open(path)
			ruleData = Rule.new(path.get_file(), "XML", xml)
		else:
			ruleData = Rule.new()
			ruleData.setErro(ERR_FILE_BAD_PATH)
		
		return ruleData

class RuleIni extends RuleInterface:
	static func _read(path):
		var ini = ConfigFile.new()
		var erro = ini.load(path)
		var ruleData:Rule
		
		if erro != OK:
			ruleData = Rule.new()
			ruleData.setErro(ERR_FILE_BAD_PATH)
		else:
			ruleData = Rule.new(path.get_file(), "INI", ini)
		
		return ruleData

const rulesPaths = {
	"JSON": "res://game_rules/json/",
	"XML": "res://game_rules/xml/",
	"INI": "res://game_rules/ini/"
}

export var Rules = {}

func getRulesAnvaliable(typeRule:String = "JSON"):
	var files = {}
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
			files[file.split(".")[0]] = (path + file)
			file = cursor.get_next()
	else:
		return ERR_FILE_NOT_FOUND
	return files

func getRule(rule, path:String) -> Rule:
	return rule._read(path)

