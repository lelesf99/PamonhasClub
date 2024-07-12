# ui.gd - Script da Cena de UI
extends CanvasLayer

@onready var time_label = $TimeLabel
@onready var work_timer = $WorkTimer
@onready var pamonha_counter_label = $PamonhaCounterLabel

var work_duration = 8 * 60  # Jornada de trabalho de 8 minutos em segundos
var remaining_time = work_duration
var pamonha_count = 0

func _ready():
	print("UI ready")
	# Conectar o sinal timeout do Timer à função de atualização
	work_timer.connect("timeout", Callable(self, "_on_work_timer_timeout"))
	# Configurar o Timer para disparar a cada segundo
	work_timer.set_wait_time(1.0)
	work_timer.start()
	print("Timer started")
	update_pamonha_counter()

func _on_work_timer_timeout():
	if remaining_time > 0:
		remaining_time -= 1
		update_time_label()
	else:
		work_timer.stop()
		end_of_workday()

func update_time_label():
	var hours = pad_with_zeroes(str(remaining_time / 3600), 2)
	var minutes = pad_with_zeroes(str((remaining_time % 3600) / 60), 2)
	var seconds = pad_with_zeroes(str(remaining_time % 60), 2)
	time_label.text = hours + ":" + minutes + ":" + seconds
	print("Time updated: ", time_label.text)

func pad_with_zeroes(value: String, length: int) -> String:
	while value.length() < length:
		value = "0" + value
	return value

func end_of_workday():
	# Aqui você pode adicionar o código que deve ser executado quando a jornada de trabalho terminar
	print("Jornada de trabalho encerrada!")

func increment_pamonha_counter():
	pamonha_count += 1
	update_pamonha_counter()

func update_pamonha_counter():
	pamonha_counter_label.text = "Pamonhas: " + str(pamonha_count)
	print("Pamonhas updated: ", pamonha_counter_label.text)
