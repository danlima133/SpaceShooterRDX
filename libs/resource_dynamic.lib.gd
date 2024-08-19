extends Script

enum TypeRand {
	INT
	FLOAT
}

enum Value {
	MIN
	MAX
	DEFAULT
}

class ResourceDynamic:
	var _resourceBase:Resource
	var _resourceOrigem:Resource
	
	var isUnique:bool
	
	func _init(resource:Resource, isUnique:bool):
		self.isUnique = isUnique
		_resourceOrigem = resource
		if isUnique:
			_resourceBase = resource
		else:
			_resourceBase = resource.duplicate()
	
	func isResouceValid():
		return _resourceBase != null
	
	func setValue(property:String, value):
		if isResouceValid():
			_resourceBase.set(property, value)
		return ERR_UNAVAILABLE
	
	func getValue(property):
		if isResouceValid():
			return _resourceBase.get(property)
		return ERR_UNAVAILABLE
	
	func resetResource():
		if not isUnique:
			_resourceBase = _resourceOrigem.duplicate()

static func isRangeValue(value:Array):
	return true if value.size() == 2 else false

static func generateRangeValue(value:Array, randType:int, algorithm:RandomNumberGenerator = null):
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

static func getValueFromRand(rand:Array, value:int):
	if rand.size() == 2 or rand.size() == 1:
		match value:
			Value.MIN:
				return rand[0]
			Value.MAX:
				return rand[1]
			Value.DEFAULT:
				return rand[0]
	return ERR_INVALID_PARAMETER

static func createNewRand(a, b = null):
	return [a, b] if b != null else [a]
