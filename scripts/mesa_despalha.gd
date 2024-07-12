extends Node2D
var highlighted = false;
var soundEffect: AudioStreamPlayer2D
const MILHO = preload("res://scenes/ingredientes/milho.tscn")
const PALHA = preload("res://scenes/ingredientes/palha.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	soundEffect = AudioStreamPlayer2D.new()
	add_child(soundEffect)
	soundEffect.stream = load("res://Trilha Sonora/objetos/corte-faca.wav")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Colocar milho
func action1(mao):
	if mao.get_child_count() == 0:
		if $MilhoComPalha.get_child_count() != 0:
			var milho = $MilhoComPalha.get_child(0)
			milho.reparent(mao, false)
	else:
		if $MilhoComPalha.get_child_count() == 0:
			var milho = mao.get_child(0)
			if !milho.is_in_group("milho_com_palha"): return
			milho.reparent($MilhoComPalha, false);

# se tiver milho na mesa, despalha ele, se não tiver e tiver passado um, já coloca na mesa e despalha
func action2(mao):
	_play_sound_effect()
	if $MilhoComPalha.get_child_count() != 0:
		$TaskTimer.start(3)
	else:
		if mao.get_child_count() < 1: return
		var milho = mao.get_child(0)
		if !milho.is_in_group("milho_com_palha"): return
		action1(mao)
		$TaskTimer.start(3)

func _on_task_timer_task_ended(result):
	var milho = $MilhoComPalha.get_child(0);
	milho.queue_free();
	$BauMilho.add_child(MILHO.instantiate());
	$BauPalha.add_child(PALHA.instantiate());
	
func _play_sound_effect():
	soundEffect.play() 
		
