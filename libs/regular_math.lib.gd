extends Script

class RectsMap:
	var _config:Dictionary
	var _map:Map

	class Map:
		var _rectsMap:RectsMap
		var _data:Dictionary
		
		func _init(data:Dictionary = {}, rectsMap:RectsMap = null):
			_data = data
			_rectsMap = rectsMap
		
		func getAllRectsOnMap():
			return _data.values()

		func getRectByPosition(position:Vector2):
			return _data.get(position, null)
		
		func getRectsInvalids(rectsGroup:Array):
			var rectsInvalids:Array = []
			for rectToValid in _data.values():
				for rectInGroup in rectsGroup:
					if rectToValid.intersects(rectInGroup):
						rectsInvalids.append(rectToValid)
		
		func setRectsMap(rectsMap:RectsMap):
			_rectsMap = rectsMap

		func removeRect(position:Vector2):
			return _data.erase(position)
		
		func addRect(rect:Rect2, parseRects:bool = true):
			if parseRects:
				rect = _rectsMap.parseRects(rect)
			var position = rect.position
			if not _data.has(position):
				_data[position] = rect
				return OK
			return ERR_ALREADY_EXISTS
		
		func clearMap():
			_data.clear()
	
	func _init(map:Map = null, config:Dictionary = {}):
		self._config = config

		if map == null:
			_map = Map.new({}, self)
		else:
			_map = map
			_map.setRectsMap(self)

	func _getSideByRectEquals(rectOrigin:Rect2, rectTarget:Rect2):
		var directionsAnvaliable = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
		var newRect:Rect2
		for direction in directionsAnvaliable:
			if rectOrigin.intersects(rectTarget):
				newRect = _getSideByDirection(rectOrigin, rectTarget, direction, false)
				if not newRect.intersects(rectTarget):
					break
		return newRect

	func _getSideByDirection(rectOrigin:Rect2, rectTarget:Rect2, direction:Vector2 = Vector2.ZERO, equals:bool = true):
		if equals:
			if rectOrigin == rectTarget:
				return _getSideByRectEquals(rectOrigin, rectTarget)
		
		var newRect:Rect2 = Rect2(0, 0, 0, 0)
		var dir = direction

		if dir == Vector2.ZERO:
			dir = rectTarget.position
		
		if rectOrigin.position.x < dir.x:
			newRect.position.x = rectTarget.position.x - rectOrigin.size.x
		elif rectOrigin.position.x > dir.x:
			newRect.position.x = rectTarget.position.x + rectTarget.size.x
			
		if rectOrigin.position.y < dir.y:
			newRect.position.y = rectTarget.position.y - rectOrigin.size.y
		elif rectOrigin.position.y > dir.y:
			newRect.position.y = rectTarget.position.y + rectTarget.size.y
		
		newRect.size = rectOrigin.size
		
		return newRect

	func _getConfig() -> Dictionary:
		return _config
	
	func parseRects(rectToParse:Rect2, newRectEnterMap:bool = true):
		var newRect:Rect2
		var rectsGroup = _map.getAllRectsOnMap()
		
		if not rectsGroup.size() > 0:
			newRect = rectToParse
		
		for rect in rectsGroup:
			if rectToParse.intersects(rect):
				var refDirection:Vector2 = Vector2.ZERO
				if _getConfig().has("axisFix"):
					var axisiFix = _getConfig()["axisFix"]
					
					if !axisiFix:
						refDirection = rect.get_center()

					newRect = _getSideByDirection(rectToParse, rect,  refDirection)
					rectToParse = newRect
			else:
				newRect = rectToParse
		
		if newRectEnterMap:
			_map.addRect(newRect, false)
					
		return newRect
