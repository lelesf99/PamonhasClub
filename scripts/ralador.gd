extends Node2D
var soundEffect: AudioStreamPlayer2D
var hints = [
	{"label": "Ralar", "type": "key", "key_label": "2"},
]
var coisa_atual = null;
# Called when the node enters the scene tree for the first time.
func _ready():
	soundEffect = AudioStreamPlayer2D.new()
	add_child(soundEffect)
	soundEffect.stream = load("res://Trilha Sonora/objetos/embalar.wav")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Interativo/Prato/Milho.get_child_count() != 0 and hints.size() == 1:
		hints = [
			{"label": "Pegar", "type": "key", "key_label": "1"},
			{"label": "Ralar", "type": "key", "key_label": "2"},
		];
		Global.update_hints(hints);
	if $Interativo/Prato/Milho.get_child_count() == 0 and hints.size() > 1:
		hints = [
			{"label": "Ralar", "type": "key", "key_label": "2"},
		];
		Global.update_hints(hints);
	pass

func action1(mao):
	if mao.get_child_count() > 0: return
	if $Interativo/Prato/Milho.get_child_count() == 0: return
	$Interativo/Prato/Milho.get_child($Interativo/Prato/Milho.get_child_count() - 1).position = Vector2.ZERO
	$Interativo/Prato/Milho.get_child($Interativo/Prato/Milho.get_child_count() - 1).reparent(mao)

func _play_sound_effect():
	soundEffect.play() 
	
func action2(mao):
	if mao.get_child_count() < 1: return
	var coisa = mao.get_child(0)
	coisa_atual = coisa;
	if coisa.is_in_group("milho"):
		$TaskTimer.start(coisa.tempo_de_ralar);
		_play_sound_effect();
		coisa_atual = coisa.ralado.instantiate();
		coisa.queue_free();
	if coisa.is_in_group("queijo"):
		$TaskTimer.start(coisa.tempo_de_ralar)
		_play_sound_effect();
		coisa_atual = coisa.ralado.instantiate();
		coisa.queue_free();

func _on_task_timer_task_ended(result):
	var coisa_ralada = coisa_atual;
	$Interativo/Prato/Milho.add_child(coisa_ralada);
	coisa_ralada.global_position = Vector2(20, 0) + global_position;

func set_hints(new_hints: Array):
	hints = new_hints;
	Global.update_hints(hints)

func get_hints(hovered_por = null):
	if hovered_por.is_in_group("milho"):
		return [
			{"label": "Ralar", "type": "key", "key_label": "2"},
		];
	if hovered_por.is_in_group("queijo"):
		return [
			{"label": "Cortar", "type": "key", "key_label": "2"},
		];
	return hints;
