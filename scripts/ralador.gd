extends Node2D
var soundEffect: AudioStreamPlayer2D
const MILHO_RALADO = preload("res://scenes/ingredientes/milho_ralado.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	soundEffect = AudioStreamPlayer2D.new()
	add_child(soundEffect)
	soundEffect.stream = load("res://Trilha Sonora/objetos/embalar.wav")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func action1(mao):
	if mao.get_child_count() > 0: return
	if $Interativo/Prato/Milho.get_child_count() == 0: return
	$Interativo/Prato/Milho.get_child($Interativo/Prato/Milho.get_child_count() - 1).position = Vector2.ZERO
	$Interativo/Prato/Milho.get_child($Interativo/Prato/Milho.get_child_count() - 1).reparent(mao, false)

func _play_sound_effect():
	soundEffect.play() 
	
func action2(mao):
	if mao.get_child_count() < 1: return
	var milho = mao.get_child(0)
	if !milho.is_in_group("milho"): return
	$TaskTimer.start(3);
	_play_sound_effect();
	milho.queue_free();

func _on_task_timer_task_ended(result):
	var milho_ralado = MILHO_RALADO.instantiate();
	$Interativo/Prato/Milho.add_child(milho_ralado);
	milho_ralado.global_position = Vector2(20, 0) + global_position;
