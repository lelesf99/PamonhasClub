extends Node2D
const FOGO = preload("res://scenes/objetos/fogo.tscn")
var hints = [
	{"label": "Cozinhar", "type": "key", "key_label": "1"}
]
var ta_pegando_fogo_bicho = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if ta_pegando_fogo_bicho:
		if $Panela.get_child_count() == 0:
			ta_pegando_fogo_bicho = false
			hints = [
				{"label": "Cozinhar", "type": "key", "key_label": "1"}
			]
			Global.update_hints(hints);
			$Interativo/Vazio.visible = true;
			$Interativo/Cozindo.visible = false;
	if $Panela.get_child_count() > 0:
		for child in $Panela.get_children():
			child.global_position = lerp(child.global_position, $Panela.global_position, 10 * delta);
	pass

func action1(mao):
	if ta_pegando_fogo_bicho: return
	
	if $Panela.get_child_count() != 0 && mao.get_child_count() == 0:
		hints = [
			{"label": "Cozinhar", "type": "key", "key_label": "1"}
		]
		Global.update_hints(hints);
		$Interativo/Vazio.visible = true;
		$Interativo/Cozindo.visible = false;
		$TaskTimer.conclude_task();
		$Panela.get_child(0).reparent(mao);
		return
	if $Panela.get_child_count() == 0 && mao.get_child_count() != 0:
		var comida = mao.get_child(0)
		if is_instance_valid(comida) && has_property(comida, "tempo_pra_cozir") && has_property(comida, "tempo_pra_queimar"):
			comida.reparent($Panela);
			hints = [
				{"label": "Pegar", "type": "key", "key_label": "1"}
			]
			Global.update_hints(hints);
			$Interativo/Vazio.visible = false;
			$Interativo/Cozindo.visible = true;
			if $TaskTimer.is_paused():
				$TaskTimer.resume();
			else:
				$TaskTimer.start(comida.tempo_pra_cozir, true, comida.tempo_pra_queimar);

func action2(mao):
	pass

func _on_task_timer_task_ended(result):
	if result == "task_finished":
		var cozido = $Panela.get_child(0).cozido.instantiate();
		$Panela.get_child(0).queue_free();
		$Panela.add_child(cozido);
		return
	if result == "fail":
		$Panela.get_child(0).queue_free();
		$Panela.add_child(FOGO.instantiate());
		ta_pegando_fogo_bicho = true
		return
		
func has_property(node: Node, property_name: String) -> bool:
	for property in node.get_property_list():
		if property.name == property_name:
			return true
	return false
