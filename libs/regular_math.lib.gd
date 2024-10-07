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

class Radom:

	class Posibility:
		enum Cases {
			SUCCSSE
			FAILED
		}
		
		var case
		var percent

	class DynamicPosibilities extends RandomNumberGenerator:
		
		class RandomInput:
			var _input = {
				"percent_base": 0,
				"percent_bonus": 0,
				"percent_fall": 0,
				"height_succsse": 5,
				"height_fall": 3
			}
			
			func set_input(input:Dictionary):
				for key in input.keys():
					if _input.has(key):
						_input[key] = input[key]
			
			func get_input(input):
				return _input.get(input)

		var __percent_base:float
		var __percent_succsse:float
		var __percent_fall:float
		var __height_succsse:int
		var __height_fall:int
		var __falls_count:int
		var __succsse_count:int
		var __succsse_bonus:float
		var __fall_bonus:float
		
		func set_random_input(input:RandomInput):
			__percent_base = input.get_input("percent_base")
			__percent_succsse = input.get_input("percent_bonus")
			__percent_fall = input.get_input("percent_fall")
			__height_succsse = int(input.get_input("height_succsse"))
			__height_fall = int(input.get_input("height_fall"))

		func get_posibility():
			var __posibility = Posibility.new()
			var __value = self.randf_range(0, 1)
			
			__succsse_bonus = __percent_succsse * ((__falls_count + 1) / __height_succsse)
			__fall_bonus = __percent_fall * ((__succsse_count + 1) / __height_fall)
			
			if  __value < __percent_base:
				__falls_count = 0
				__succsse_count += 1
				__percent_base -= __fall_bonus
				__posibility.case = __posibility.Cases.SUCCSSE
			else:
				__falls_count += 1
				__succsse_count = 0
				__percent_base += __succsse_bonus
				__posibility.case = __posibility.Cases.FAILED
				
			__percent_base = clamp(__percent_base, 0, 1)
			
			__posibility.percent = __percent_base
			
			return __posibility
	
		func get_posibility_with_count(counts):
			var __count:int
			
			for count in range(counts):
				var __posibility = get_posibility()
				if __posibility.case == Posibility.Cases.SUCCSSE:
					__count += 1
			return __count
		
		func get_posibility_as_list(list_size):
			var list = []
			for index in range(list_size):
				list.append(get_posibility())
			return list

	static func get_posibility_by_percent(percent, algorithm:RandomNumberGenerator = null):
		var posibility = Posibility.new()
		posibility.percent = percent
		
		var value:float
		
		if algorithm != null:
			value = algorithm.randf_range(0, 1)
		else:
			value = rand_range(0, 1)
		
		if value < percent:
			posibility.case = posibility.Cases.SUCCSSE
		else:
			posibility.case = posibility.Cases.FAILED
		
		return posibility

static func percent_to_decimal(percent) -> float:
	return (float(percent) / 100)

static func decimal_to_percent(decimal) -> float:
	return (decimal * 100)
