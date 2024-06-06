extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.is_in_group("player_interaction"):
		$Vazio.self_modulate = Color.GAINSBORO;
		$Cozindo.self_modulate = Color.GAINSBORO;
		Global.set_highlight(self)

func _on_area_2d_body_exited(body):
	if body.is_in_group("player_interaction"):
		$Vazio.self_modulate = Color.WHITE;
		$Cozindo.self_modulate = Color.WHITE;
		Global.set_highlight(null)

func put_obj(obj):
	if is_instance_valid(obj) && obj.tempo_pra_cozir && obj.tempo_pra_queimar:
		if $Panela.get_child_count() == 0:
			obj.reparent($Panela);
			obj.global_position = $Panela.global_position;
			$Vazio.visible = false;
			$Cozindo.visible = true;
			$TaskTimer.start(obj.tempo_pra_cozir, true, obj.tempo_pra_queimar);

func get_obj():
	if $Panela.get_child_count() != 0:
		$Vazio.visible = true;
		$Cozindo.visible = false;
		$TaskTimer.conclude_task();
		return $Panela.get_child(0);


func _on_task_timer_task_ended(result):
	if result == "task_finished":
		var cozido = $Panela.get_child(0).cozido.instantiate();
		$Panela.get_child(0).queue_free();
		$Panela.add_child(cozido);
