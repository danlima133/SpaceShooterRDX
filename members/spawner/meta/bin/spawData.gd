extends Resource
class_name SpawData

enum FunctionsModels {
	DEFAULT
}

export(PoolIntArray) var timeSpaw
export(PoolIntArray) var countToSpaw

export(Dictionary) var entityPosition = {
	"x": [],
	"y": []
}

export(String, FILE, "*.tscn") var entity
export(int) var countEntities

export(bool) var useFunction
export(FunctionsModels) var typeModel
