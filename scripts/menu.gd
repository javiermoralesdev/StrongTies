extends CanvasLayer

const SAVE_GAME_PATH = "user://settings.tres"
@onready var settings_data = SettingsData.new()

func _ready() -> void:
	if OS.get_name() == "Web" or OS.get_name() == "Android":
		$MainMenu/VBoxContainer/QuitButton.queue_free()
		$Settings/VBoxContainer/Fullscreen.queue_free()
	if ResourceLoader.exists(SAVE_GAME_PATH):
		settings_data = load(SAVE_GAME_PATH) as SettingsData
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(settings_data.music_vol))
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), linear_to_db(settings_data.sound_vol))
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if settings_data.fullscreen else DisplayServer.WINDOW_MODE_WINDOWED)
	
	$Settings/VBoxContainer/MusicSlider.value = settings_data.music_vol * 100
	$Settings/VBoxContainer/SoundSlider.value = settings_data.sound_vol * 100
	$Settings/VBoxContainer/Fullscreen.button_pressed = settings_data.fullscreen
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

func update_music(music: float):
	var normalized = music/100;
	var db = linear_to_db(normalized)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), db)
	settings_data.music_vol = normalized
	ResourceSaver.save(settings_data, SAVE_GAME_PATH)

func update_sounds(music: float):
	var normalized = music/100;
	var db = linear_to_db(normalized)
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sound"), db)
	settings_data.sound_vol = normalized
	ResourceSaver.save(settings_data, SAVE_GAME_PATH)

func update_fullscreen(fs: bool):
	settings_data.fullscreen = fs
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN if fs else DisplayServer.WINDOW_MODE_WINDOWED)
	ResourceSaver.save(settings_data, SAVE_GAME_PATH)

func go_back():
	Transition.transition()
	await Transition.on_transition_finished
	$MainMenu.visible = true
	$Credits.visible = false
	$Settings.visible = false

func hover():
	$HoverPlayer.play()

func click_effect():
	$ClickPlayer.play()
