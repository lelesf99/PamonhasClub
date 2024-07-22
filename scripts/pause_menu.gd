extends Control
@onready var optionsMenu = preload("res://scenes/pause_menu.tscn")
func _ready():
	pass

func resume():
	$".".visible = false;

func pause():
	$".".visible = true;

func _process(delta):
	if Input.is_action_just_pressed("esc") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("esc") and get_tree().paused:
		resume()

func _on_options_pressed():
	resume()
	get_tree().change_scene_to_file("res://scenes/pause_menu.tscn")

func _on_retomar_pressed():
	resume()

func _on_menu_pressed():
	get_tree().change_scene_to_file('res://scenes/menu.tscn');
