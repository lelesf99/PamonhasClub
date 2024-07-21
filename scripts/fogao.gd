extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Panela.get_child_count() > 0:
		for child in $Panela.get_children():
			child.global_position = lerp(child.global_position, $Panela.global_position, 10 * delta);
	pass

func action1(mao):
	if $Panela.get_child_count() != 0 && mao.get_child_count() == 0:
		$Interativo/Vazio.visible = true;
		$Interativo/Cozindo.visible = false;
		$TaskTimer.conclude_task();
		$Panela.get_child(0).reparent(mao);
		return
	if $Panela.get_child_count() == 0 && mao.get_child_count() != 0:
		var comida = mao.get_child(0)
		if is_instance_valid(comida) && comida.tempo_pra_cozir && comida.tempo_pra_queimar:
			if $Panela.get_child_count() == 0:
				comida.reparent($Panela);
				$Interativo/Vazio.visible = false;
				$Interativo/Cozindo.visible = true;
				$TaskTimer.start(comida.tempo_pra_cozir, true, comida.tempo_pra_queimar);

func action2(mao):
	pass

func _on_task_timer_task_ended(result):
	if result == "task_finished":
		var cozido = $Panela.get_child(0).cozido.instantiate();
		$Panela.get_child(0).queue_free();
		$Panela.add_child(cozido);
