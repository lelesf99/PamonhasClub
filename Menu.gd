extends Control
@export var new_music: AudioStream
	
func _ready():
	var default_music = load("res://Trilha Sonora/Pense Em Mim (Karaoke).wav")
	if MusicaFundo.music_player.stream != default_music:
		MusicaFundo.play_music(default_music)
	for button in get_tree().get_nodes_in_group("button"):
		button.connect("pressed", self.on_button_pressed.bind(button))
		button.connect("mouse_exited", self.mouse_interaction.bind(button, "exited"))
		button.connect("mouse_entered", self.mouse_interaction.bind(button, "entered"))

func on_button_pressed(button: Button) -> void:
	match button.name:
		"Jogar":
			MusicaFundo.stop_music()
			var default_music = load("res://Trilha Sonora/E O Amor (Karaoke).WAV")
			MusicaFundo.play_music(default_music)
			get_tree().change_scene_to_file("res://scenes/main.tscn")
		"Controles":
			get_tree().change_scene_to_file("res://scenes/controles.tscn")
		"Créditos":
			get_tree().change_scene_to_file("res://scenes/creditos.tscn")
		"Sair":
			get_tree().quit()
			MusicaFundo.stop_music()

func mouse_interaction(button: Button, state: String) -> void:
	match state:
		"exited":
			button.modulate.a = 1.0
		"entered":
			button.modulate.a = 0.5
