extends Script

enum TypeRand {
	INT
	FLOAT
}

class ResourceDynamic:
	var _resourceBase:Resource
	
	func _init(resource:Resource, isUnique:bool):
		if isUnique:
			_resourceBase = resource
		else:
			_resourceBase = resource.duplicate()
	
	func isResouceValid():
		return _resourceBase != null
	
	func setValue(property:String, value):
		if isResouceValid():
			_resourceBase.set(property, value)
		else: ERR_UNAVAILABLE
	
	func getValue(property):
		if isResouceValid():
			return _resourceBase.get(property)
		else: ERR_UNAVAILABLE

static func isRangeValue(value:Array):
	return true if value.size() == 2 else false

static func generateRangeValue(value:Array, randType, algorithm:RandomNumberGenerator = null):
	var randValue
	if algorithm == null:
		randomize()
		randValue = rand_range(value[0], value[1])
	else:
		randValue = algorithm.randf_range(value[0], value[1])
	
	if randType == TypeRand.INT:
		return int(randValue)
	elif randType == TypeRand.FLOAT:
		return randValue
	else: return ERR_INVALID_PARAMETER
