extends Node2D


func _ready():
	Dialogic.signal_event.connect(signal_handler)
	Dialogic.start("main")

func signal_handler(sig_name):
	match sig_name:
		"stop_music":
			pass
