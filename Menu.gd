extends Control

func _on_ready():
	$AudioStreamPlayer2D.play()
	
func _ready():
	$AudioStreamPlayer2D.play()
	for button in get_tree().get_nodes_in_group("button"):
		button.connect("pressed", self.on_button_pressed.bind(button))
		button.connect("mouse_exited", self.mouse_interaction.bind(button, "exited"))
		button.connect("mouse_entered", self.mouse_interaction.bind(button, "entered"))

func on_button_pressed(button: Button) -> void:
	match button.name:
		"Jogar":
			get_tree().change_scene_to_file("res://scenes/main.tscn")
			$AudioStreamPlayer2D.stop()
		"Controles":
			get_tree().change_scene_to_file("res://scenes/main.tscn")
		"Créditos":
			get_tree().change_scene_to_file("res://scenes/main.tscn")
		"Sair":
			get_tree().quit()
			$AudioStreamPlayer2D.stop()

func mouse_interaction(button: Button, state: String) -> void:
	match state:
		"exited":
			button.modulate.a = 1.0
		"entered":
			button.modulate.a = 0.5
