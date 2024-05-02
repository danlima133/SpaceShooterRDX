extends Resource
class_name MotionConfig

export(int) var velocity
export(int) var velocityMin
export(int) var velocityMax

export(Vector2) var direction

export(bool) var directionRandom = true
export(bool) var velocityRandom = true

export(Dictionary) var axioFix = {
	"axioX": {
		"fix": false,
		"value": 0
	},
	"axioY": {
		"fix": false,
		"value": 0
	}
}
