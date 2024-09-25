extends Node

const RegularMath = preload("res://libs/regular_math.lib.gd")

func _ready():
	var input = RegularMath.Radom.RandomInput.new()
	var number = input.format_number("50%")
	
	input.set_input({
		"percent_base": "3%",
		"percent_bonus": "2%",
		"percent_fall": "4%"
	})
	
	var random_posibilities = RegularMath.Radom.new()
	random_posibilities.randomize()
	var __posibilities = random_posibilities.generate_list_posibilities(20, input)
	for posibility in __posibilities:
		if posibility.case == posibility.Cases.OK:
			print("create statrs", " ", random_posibilities.decimal_to_percent(posibility.current_percent))
		else:
			print("no stars", " ", random_posibilities.decimal_to_percent(posibility.current_percent))
