extends Script

static func getSide(rectBase:Rect2, rectTarget:Rect2, offset:int = 0):
	var rect:Rect2
	if rectBase.position == rectTarget.position:
		return null
	if rectBase.position.x < rectTarget.position.x:
		rect.position.x = rectTarget.position.x - rectBase.size.x
	elif rectBase.position.x > rectTarget.position.x:
		rect.position.x = rectTarget.position.x + rectTarget.size.x
	
	if rectBase.position.y < rectTarget.position.y:
		rect.position.y = rectTarget.position.y - rectBase.size.y
	elif rectBase.position.y > rectTarget.position.y:
		rect.position.y = rectTarget.position.y + rectTarget.size.y
	rect.size = rectBase.size
	return rect

static func getRectNoIntersects(rects:Array, testRect:Rect2):
	var output:Rect2
	var dir:Vector2
	var lastRect:Rect2
	if not rects.size() > 0:
		output = testRect
	for rect in rects:
		if testRect.intersects(rect):
			print(testRect)
			var newR = getSide(testRect, rect)
			if newR != null:
				testRect = newR
				output = newR
				print(testRect, rect)
				break
		else:
			output = testRect
	return output
