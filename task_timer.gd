# task_timer.gd
extends Node

@export var work_duration = 8 * 60 * 60 # Jornada de trabalho de 8 horas em segundos
var remaining_time = work_duration

# Referência ao Label para atualizar o tempo restante
@onready var time_label = get_node("/root/YourMainScene/TimeLabel")
@onready var work_timer = get_node("/root/YourMainScene/WorkTimer")

func _ready():
	# Conecta o sinal timeout do Timer à função de atualização
	work_timer.connect("timeout", self, "_on_work_timer_timeout")
	# Configura o Timer para disparar a cada segundo
	work_timer.set_wait_time(1.0)
	work_timer.start()

func _on_work_timer_timeout():
	if remaining_time > 0:
		remaining_time -= 1
		update_time_label()
	else:
		work_timer.stop()
		end_of_workday()

func update_time_label():
	var hours = remaining_time / 3600
	var minutes = (remaining_time % 3600) / 60
	var seconds = remaining_time % 60
	time_label.text = str(hours).pad_zero(2) + ":" + str(minutes).pad_zero(2) + ":" + str(seconds).pad_zero(2)

func end_of_workday():
	# Aqui você pode adicionar o código que deve ser executado quando a jornada de trabalho terminar
	print("Jornada de trabalho encerrada!")
