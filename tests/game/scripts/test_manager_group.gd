extends Node

const Groups = preload("res://libs/groups.lib.gd")

var manager = Groups.Manager.new()

func _ready():
	manager.initManager(self)
	
	print(manager.hasGroup("sprites"))
	print(manager.getMemberWithTag("sprites", "texture2"))
	
	print(manager.getMembersInGroup("test"))
	print(manager.getMemberWithTag("test", "oppo"))
	print(manager.hasGroup("test"))
	print(manager.hasTagOnGroup("test", "oppo"))
	
	if manager.hasGroup("sprites"):
		if manager.hasTagOnGroup("sprites", "texture"):
			var sprite = manager.getMemberWithTag("sprites", "texture")
			sprite = sprite.getOutputObject()
			sprite.texture = load("res://assets/sprites/power_ups/pill_red.png")
		
		if manager.hasTagOnGroup("sprites", "texture2"):
			var sprite2 = manager.getMemberWithTag("sprites", "texture2")
			sprite2 = sprite2.getOutputObject()
			sprite2.texture = load("res://assets/sprites/power_ups/bolt_gold.png")
		
	var nodesGroup = manager.getMembersInGroup("sprites")
	print(nodesGroup)

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_0:
					if manager.hasTagOnGroup("animation", "anim"):
						var anim = manager.getMemberWithTag("animation", "anim")
						anim = anim.getOutputObject() as Tween
						if !anim.is_active():
						
							var sprite = manager.getMemberWithTag("sprites", "texture")
							sprite = sprite.getOutputObject()
							
							anim.interpolate_property(sprite, "global_position:x", sprite.global_position.x, sprite.global_position.x + 50, 2, Tween.TRANS_BOUNCE, Tween.EASE_OUT)
							anim.start()
							var nodesGroup = manager.getMembersInGroup("animation")
							var node:MemberGroup = nodesGroup.get("anim", null)
							print(node.getOutputObject())
