extends Node

onready var manager_events = $ManagerEvents

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_M:
					var err = manager_events.startEvent("meteorsFlame")
					if err != OK:
						print("err - event start")
				KEY_S:
					var err = manager_events.stopEvent()
					if err != OK:
						print("err - event stop")
				KEY_R:
					var err = manager_events.resumeEvent()
					if err != OK:
						print("err - event resume")


func _on_event_meteors_eventFinished(event):
	print("event - finished: %s" % event.getEventName())

func _on_event_meteors_eventStart(event):
	print("event - start: %s" % event.getEventName())
