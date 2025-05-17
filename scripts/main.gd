extends Node2D

@export var menu_buttons: Array[Button]
var shown = false

func _ready():
	Dialogic.signal_event.connect(signal_handler)
	Dialogic.start("main")
	hide_menu()

func signal_handler(sig_name):
	match sig_name:
		"itch":
			OS.shell_open("google.com")
			pass
		"github":
			OS.shell_open("https://github.com/javiermoralesdev/StrongTies")
			pass
		"other":
			OS.shell_open("https://javier-morales-dev.itch.io/")
			pass
		"end":
			quit_game()
			

func hide_menu():
	shown = false
	for button in menu_buttons:
		button.visible = false
		

func activate_menu():
	shown = true
	for button in menu_buttons:
		button.visible = true


func _on_menu_button_pressed() -> void:
	if shown:
		hide_menu()
	else:
		activate_menu()

func save_game():
	Dialogic.Save.save("main_slot")

func quit_game():
	Transition.transition()
	await Transition.on_transition_finished
	Dialogic.end_timeline()
	get_tree().change_scene_to_file("res://scenes/menu.tscn")

func _on_save_button_pressed() -> void:
	save_game()
	hide_menu()


func _on_load_button_pressed() -> void:
	Dialogic.Save.load("main_slot")
	hide_menu()


func _on_save_exit_button_pressed() -> void:
	save_game()
	quit_game()


func _on_no_save_exit_button_pressed() -> void:
	quit_game()
