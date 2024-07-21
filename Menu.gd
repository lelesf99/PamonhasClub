extends Control
@export var new_music: AudioStream
	
func _ready():
	for button in get_tree().get_nodes_in_group("button"):
		button.connect("pressed", self.on_button_pressed.bind(button))
		button.connect("mouse_exited", self.mouse_interaction.bind(button, "exited"))
		button.connect("mouse_entered", self.mouse_interaction.bind(button, "entered"))

func on_button_pressed(button: Button) -> void:
	match button.name:
		"Jogar":
			get_tree().change_scene_to_file("res://scenes/main.tscn")
		"Controles":
			get_tree().change_scene_to_file("res://scenes/controles.tscn")
		"Créditos":
			get_tree().change_scene_to_file("res://scenes/creditos.tscn")
		"Sair":
			get_tree().quit()

func mouse_interaction(button: Button, state: String) -> void:
	match state:
		"exited":
			button.modulate.a = 1.0
		"entered":
			button.modulate.a = 0.5
