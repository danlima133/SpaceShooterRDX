extends Script

class RectsMap:
	class Map extends Node2D:
		
		var _config:Dictionary
		var _map:Dictionary
		
		var _debug:bool
		
		var sizeX:int
		var sizeY:int
		var cellSize:int
		var origin:Vector2
		var offset:Vector2
		
		func _init(config:Dictionary, root = null):
			_config = config
			_setConfig()
			if root != null:
				root.add_child(self, true)
			_generateMap()
		
		func _draw():
			z_index = 100
			if _debug:
				var cells = getRectsAnvaliables()
				for cell in cells:
					draw_rect(cell, Color.red, false)
					draw_line(cell.get_center(), cell.get_center() - Vector2(0, cell.size.y/2), Color.black)
					draw_line(cell.get_center(), cell.get_center() - Vector2(cell.size.x/2, 0), Color.black)
					draw_line(cell.position, cell.position + cell.size, Color.gray)
					draw_circle(cell.get_center(), 2.5, Color.white)
				draw_circle(origin, 3.5, Color.green)
				if offset != Vector2.ZERO:
					draw_circle(origin + offset, 3.5, Color.blue)
		
		func _setConfig():
			if _config.has("id"):
				self.name = _config["id"]
			var _size = _config.get("size", [])
			if _size.size() > 0:
				sizeX = _size["x"]
				sizeY = _size["y"]
			cellSize = _config.get("cellSize", 0)
			origin = _config.get("origin", Vector2.ZERO)
			offset = _config.get("offset", Vector2.ZERO)
			debugActive(_config.get("debug", false))
		
		func _generateMap():
			for x in range(sizeX):
				for y in range(sizeY):
					var rect = Rect2((x * cellSize) + origin.x, (y * cellSize) + origin.y, cellSize, cellSize)
					rect.position += offset
					_map[toPositionWolrd2PositionMap(rect.position)] = rect
			update()
		
		func toPositionWolrd2PositionMap(position:Vector2, cellFit:bool = true):
			var newPosition:Vector2
			
			newPosition.x = position.x / cellSize
			newPosition.y = position.y / cellSize
			if cellFit:
				newPosition.x = int(newPosition.x)
				newPosition.y = int(newPosition.y)
			return newPosition
		
		func toPositionMap2PositionWolrd(position:Vector2):
			var newPosition:Vector2
			newPosition.x = position.x * cellSize
			newPosition.y = position.y * cellSize
			return newPosition
		
		func getPositionsAnvaliables():
			return _map.keys()
		
		func getRectsAnvaliables():
			return _map.values()
		
		func getRealSize():
			return Vector2(sizeX * cellSize, sizeY * cellSize)
		
		func getRectByPosition(position:Vector2):
			return _map[position] if _map.has(position) else ERR_INVALID_PARAMETER
		
		func debugActive(active:bool):
			_debug = active
			update()
		
		func isDebug() -> bool:
			return _debug
		
		func redefineMap(config:Dictionary = {}):
			self._map = {}
			if not config.empty():
				self._config = config
				_setConfig()
			_generateMap()
		
		func redefineOrigin(origin:Vector2):
			self._map = {}
			self.origin = origin
			_generateMap()
	
	var _map:Map
	var _algorithm:RandomNumberGenerator
	
	func _init(map:Map, algorithm:RandomNumberGenerator):
		_map = map
		_algorithm = algorithm
	
	func changeMap(map:Map):
		_map = map
	
	func getPositionsByCount(count:int):
		var positionsAnvaliables = _map.getPositionsAnvaliables()
		var positionsByCount:Array
		for step in range(count):
			if positionsAnvaliables.size() == 0:
				break
			var anvaliableCount = positionsAnvaliables.size()
			var index = _algorithm.randi() % anvaliableCount
			var positionChoice = positionsAnvaliables[index]
			positionsAnvaliables.erase(positionChoice)
			positionsByCount.append(positionChoice)
		return positionsByCount

class TimeData:
	var _seconds:float
	var _minutes:int
	var _hour:int
	
	func get_time_in_seconds() -> float:
		var _seconds_:float
		_seconds_ = _hour * 3600
		_seconds_ += _minutes * 60
		_seconds_ += _seconds
		return _seconds_
	
	func time() -> Array:
		return [_seconds, _minutes, _hour]
	
	func set_time_by_seconds(seconds):
		var format_seconds = int((seconds / 60))
		format_seconds = format_seconds * 60
		format_seconds = abs(seconds - format_seconds)
		_seconds = format_seconds
		_minutes = seconds / 60
		_hour = _minutes / 60
	
	func set_time(seconds, minutes, hours):
		_seconds = seconds
		_minutes = minutes
		_hour = hours
