extends CanvasLayer

const SAVE_GAME_PATH = "user://settings.tres"
@onready var settings_data: SettingsData

func _on_play_button_pressed() -> void:
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().change_scene_to_file("res://scenes/main.tscn")




func _on_settings_button_pressed() -> void:
	Transition.transition()
	await Transition.on_transition_finished
	$MainMenu.visible = false
	$Settings.visible = true




func _on_credits_button_pressed() -> void:
	Transition.transition()
	await Transition.on_transition_finished
	$MainMenu.visible = false
	$Credits.visible = true




func _on_quit_button_pressed() -> void:
	Transition.transition()
	await Transition.on_transition_finished
	get_tree().quit()
