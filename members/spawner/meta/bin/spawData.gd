extends Resource
class_name SpawData

export(PoolIntArray) var timeSpaw
export(PoolIntArray) var countToSpaw

export(Dictionary) var entityPosition = {
	"x": [],
	"y": []
}

export(bool) var useFunction
