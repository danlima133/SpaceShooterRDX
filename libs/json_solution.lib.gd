extends Script

class JsonSolution:
	var _xml:XMLParser
	var _solution
	
	func _init(xml:XMLParser):
		_xml = xml
		_solution = _generateSolution()
	
	func _generateSolution():
		var solution = {}
		
		var lastTagScope:String
		var childsTree:Dictionary
		
		while _xml.read() != ERR_FILE_EOF:
			
			var tagName = _xml.get_node_name()
			var tagAttributes = {}
			var tagScope = "main"
			var tagJson:Dictionary
			
			if tagName == "main":
				solution = ERR_PARSE_ERROR
				break
			
			var attributesCount = _xml.get_attribute_count()
			for index in range(attributesCount):
				var valueAttribute = _xml.get_attribute_value(index)
				valueAttribute = _escapeString(valueAttribute)
				tagAttributes[_xml.get_attribute_name(index)] = valueAttribute
			
			if _xml.is_empty():
				tagScope = lastTagScope
				childsTree[lastTagScope][tagName] = _getTagJson(tagName, tagAttributes, tagScope)
			else:
				lastTagScope = _xml.get_node_name()
				tagScope = "main"
				childsTree[tagName] = {}
				tagJson = _getTagJson(tagName, tagAttributes, tagScope, childsTree[tagName])
				solution[tagName] = tagJson
			
			_xml.read()
			
		return solution
	
	func _getTagJson(tagName, tagAttr, tagScope, tagChilds = null) -> Dictionary:
		var tag = {
			"name": tagName,
			"attributes": tagAttr,
			"scope": tagScope
			}
		if tagChilds != null:
			tag["childs"] = tagChilds
		return tag
	
	func _escapeString(input:String):
		var attributeParsed = input
		
		var inputSplint = input.split("?")
		
		if inputSplint.size() == 2:
			var parseType = inputSplint[0]
			var parseContent = inputSplint[1]
		
			if parseType == "json":
				var parseJson = JSON.parse(parseContent)
				if parseJson.error != OK:
					attributeParsed = (parseJson.error_string + " - line: %s") % parseJson.error_line
				else:
					attributeParsed = parseJson.result
			elif parseType == "ini":
				var ini = ConfigFile.new()
				var erro = ini.parse(parseContent)
				if erro == OK:
					attributeParsed = ini
				else:
					attributeParsed = "ini sintaxe erro"
			elif parseType == "exp":
				var experssion = Expression.new()
				experssion.parse(parseContent)
				var output = experssion.execute()
				if experssion.has_execute_failed():
					attributeParsed = "error: " + experssion.get_error_text()
				else:
					attributeParsed = output
			else:
				attributeParsed = "not found escape type: " + parseType
		
		return attributeParsed
	
	func getSolution():
		return _solution

static func getTagJsonBySolution(solution:Dictionary, parent:String, child:String = ""):
	if solution.empty():
		return ERR_INVALID_DATA
	
	if solution.has(parent):
		var tagParent = solution[parent]
		if tagParent.has("childs"):
			if tagParent["childs"].has(child):
				return tagParent["childs"][child]
		return solution[parent]
	return ERR_INVALID_PARAMETER

static func getChildsOfScope(solution:Dictionary, scope:String):
	if solution.empty():
		return ERR_INVALID_DATA
	
	if solution.has(scope):
		var tag = solution[scope]
		return tag["childs"]
	else: return ERR_DOES_NOT_EXIST
