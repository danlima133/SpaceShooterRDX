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
		
		func _init(config:Dictionary):
			_config = config
			_setConfig()
			_generateMap()
		
		func _draw():
			z_index = 100
			if _debug:
				var cells = getRectsAnvaliables()
				for cell in cells:
					draw_rect(cell, Color.red, false)
					draw_line(cell.get_center(), cell.get_center() - Vector2(0, cell.size.y/2), Color.black)
					draw_line(cell.get_center(), cell.get_center() - Vector2(cell.size.x/2, 0), Color.black)
					draw_line(cell.get_center(), cell.position, Color.gray)
					draw_circle(cell.get_center(), 2.5, Color.white)
				draw_circle(origin, 3.5, Color.green)
				if offset != Vector2.ZERO:
					draw_circle(origin + offset, 3.5, Color.blue)
		
		func _setConfig():
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
