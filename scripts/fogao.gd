extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func action1(mao):
	if $Panela.get_child_count() != 0 && mao.get_child_count() == 0:
		$Area2D/Vazio.visible = true;
		$Area2D/Cozindo.visible = false;
		$TaskTimer.conclude_task();
		$Panela.get_child(0).reparent(mao, false);
		return
	if $Panela.get_child_count() == 0 && mao.get_child_count() != 0:
		var comida = mao.get_child(0)
		if is_instance_valid(comida) && comida.tempo_pra_cozir && comida.tempo_pra_queimar:
			if $Panela.get_child_count() == 0:
				comida.reparent($Panela, false);
				$Area2D/Vazio.visible = false;
				$Area2D/Cozindo.visible = true;
				$TaskTimer.start(comida.tempo_pra_cozir, true, comida.tempo_pra_queimar);

func action2(mao):
	pass

func _on_task_timer_task_ended(result):
	if result == "task_finished":
		var cozido = $Panela.get_child(0).cozido.instantiate();
		$Panela.get_child(0).queue_free();
		$Panela.add_child(cozido);
