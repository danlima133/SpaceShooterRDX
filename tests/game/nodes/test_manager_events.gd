extends Node

onready var managerEvents = $ManagerEvents

func _input(event):
	if event is InputEventKey:
		if event.pressed:
			match event.scancode:
				KEY_E:
					managerEvents.startEvent("test")
				KEY_S:
					managerEvents.stopEvent()
				KEY_R:
					managerEvents.resumeEvent()

func _on_test_event_eventFinished(event):
	print("event test finished")

func _on_ManagerEvents_eventStop(event):
	print("event stop: " + event.getEventName())

func _on_ManagerEvents_eventResume(event):
	print("event resume: " + event.getEventName())
	
func _on_ManagerEvents_eventsConfigs(eventsInit):
	print("the manager config: %s" % eventsInit)
