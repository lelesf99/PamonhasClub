extends Node2D
var highlighted = false;
var soundEffect: AudioStreamPlayer2D
const MILHO = preload("res://scenes/ingredientes/milho.tscn")
const PALHA = preload("res://scenes/ingredientes/palha.tscn")
const hints = [
	{"label": "Colocar", "type": "key", "key_label": "1"},
	{"label": "Despalhar", "type": "key", "key_label": "2"},	
]

# Called when the node enters the scene tree for the first time.
func _ready():
	soundEffect = AudioStreamPlayer2D.new()
	add_child(soundEffect)
	soundEffect.stream = load("res://Trilha Sonora/objetos/corte-faca.wav")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $MilhoComPalha.get_child_count() > 0:
		for child in $MilhoComPalha.get_children():
			child.global_position = lerp(child.global_position, global_position, 10 * delta);

# Colocar milho
func action1(mao):
	if mao.get_child_count() == 0:
		if $MilhoComPalha.get_child_count() != 0:
			var milho = $MilhoComPalha.get_child(0)
			milho.reparent(mao)
	else:
		if $MilhoComPalha.get_child_count() == 0:
			var milho = mao.get_child(0)
			if !milho.is_in_group("milho_com_palha"): return
			milho.reparent($MilhoComPalha);

# se tiver milho na mesa, despalha ele, se não tiver e tiver passado um, já coloca na mesa e despalha
func action2(mao):
	if $MilhoComPalha.get_child_count() != 0:
		_play_sound_effect()
		$TaskTimer.start(3)
	else:
		if mao.get_child_count() < 1: return
		var milho = mao.get_child(0)
		if !milho.is_in_group("milho_com_palha"): return
		action1(mao)
		_play_sound_effect()
		$TaskTimer.start(3)

func _on_task_timer_task_ended(result):
	var milho = $MilhoComPalha.get_child(0);
	milho.queue_free();
	$BauMilho.add_child(MILHO.instantiate());
	$BauPalha.add_child(PALHA.instantiate());
	
func _play_sound_effect():
	soundEffect.play() 
		
