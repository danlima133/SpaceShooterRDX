extends Node

const RegularMath = preload("res://libs/regular_math.lib.gd")

var random_posibilities:RegularMath.Radom.DynamicPosibilities

func _ready():
	var input = RegularMath.Radom.DynamicPosibilities.RandomInput.new()
	
	input.set_input({
		"percent_base": RegularMath.percent_to_decimal(3),
		"percent_bonus": RegularMath.percent_to_decimal(1),
		"percent_fall": RegularMath.percent_to_decimal(5),
		"heigth_succsse": 4,
		"height_fall": 1
	})
	
	random_posibilities = RegularMath.Radom.DynamicPosibilities.new()
	random_posibilities.set_random_input(input)
	random_posibilities.randomize()

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_0:
					var posibility:RegularMath.Radom.Posibility = random_posibilities.get_posibility()
					print(posibility.case, " ", posibility.percent)
				KEY_1:
					var posibility:RegularMath.Radom.Posibility = RegularMath.Radom.get_posibility_by_percent(RegularMath.percent_to_decimal(25))
					print(posibility.case)
