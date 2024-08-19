extends Resource
class_name SpawData

enum Functions {
	CONST
	VARIATION
}

export(PoolIntArray) var timeSpaw
export(PoolIntArray) var countToSpaw

export(Dictionary) var entityPosition = {
	"x": [],
	"y": []
}

export(Dictionary) var spawValues = {
	"tolerance": -1,
	"offset": -1
}

export(bool) var useFunction
export(Functions) var typeFunction
export(String, FILE, "*.functiondata") var functionData

func getFunctionAsString(args:Array):
	var function = args[0]
	match function:
		Functions.CONST:
			return "constValue"
		Functions.VARIATION:
			return "deltaValue"
	return ERR_INVALID_PARAMETER
