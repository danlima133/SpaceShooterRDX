extends Function

export(int) var offset

func _action():
	setStepValue(getStepValue() + offset)
