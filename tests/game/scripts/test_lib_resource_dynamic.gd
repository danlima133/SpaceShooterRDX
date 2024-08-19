extends Node

const resourceDynamic = preload("res://libs/resource_dynamic.lib.gd")

const resource = preload("res://members/spawner/meta/data/meteors.tres")

func _ready():
	var r1 = resourceDynamic.ResourceDynamic.new(resource, true)
	var r2 = resourceDynamic.ResourceDynamic.new(resource, false)
	
	# --- TEST r1 ---
	print("resource dynamic - 1 (unique)")
	print(r1.getValue("useFunction"))
	r1.setValue("useFunction", false)
	print(r1.getValue("useFunction"))
	print("-----------------")
	
	print("resource origin")
	print(resource.get("useFunction"))
	# END
	
	print("\n")
	
	# --- TEST r2 ---
	print("resource dynamic - 2 (not unique)")
	print(r2.getValue("useFunction"))
	r2.setValue("useFunction", true)
	print(r2.getValue("useFunction"))
	print("-----------------")
	
	print("resource origin")
	print(resource.get("useFunction"))
	# END
	
	print("\n")
	
	# --- TEST r3 ---
	print("resource dynamic - 3 (unique)")
	print(r1.getValue("useFunction"))
	print("-----------------")
	
	print("resource origin")
	print(resource.get("useFunction"))
	# END
	
	print("\n")
	
	# Values Rand
	print("value is rand | value: %s" % resource.timeSpaw)
	print(resourceDynamic.isRangeValue(resource.timeSpaw))
	print("-----------------")
	
	print("rand numbers")
	var algo = RandomNumberGenerator.new()
	algo.randomize()
	print(resourceDynamic.generateRangeValue(resource.timeSpaw, resourceDynamic.TypeRand.INT, algo))
	
