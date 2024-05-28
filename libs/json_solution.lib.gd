extends Script

class JsonSolution:
	var _xml:XMLParser
	var _solution
	
	func _init(xml:XMLParser):
		self._xml = xml
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
				var isJson = valueAttribute.split("?")
				if isJson.size() == 2:
					var parse = JSON.parse(isJson[1])
					if parse.error != OK:
						valueAttribute = str(parse.error_line) + " - " + parse.error_string
					else:
						if isJson[0] == "json":
							valueAttribute = parse.result
						else:
							valueAttribute = "json to parse not found: " + isJson[0] + "?" + isJson[1]
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
