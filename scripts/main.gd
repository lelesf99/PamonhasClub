# Main.gd - Script da Cena Principal
extends Node2D

@onready var ui_container = $UIContainer  # Referência ao nó UIContainer (Control)

var ui_scene

func _ready():
	# Carregar a cena de UI
	ui_scene = load("res://scenes/Ui.tscn").instance()
	ui_container.add_child(ui_scene)

	# Você pode acessar o script da UI se precisar configurar algo adicional
	var ui_script = ui_scene.get_script()
	ui_script.work_duration = 8 * 60 * 60  # 8 horas em segundos
	ui_script.remaining_time = ui_script.work_duration
