extends Node2D
const MILHO_RALADO = preload("res://scenes/ingredientes/milho_ralado.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func action1(mao):
	if mao.get_child_count() > 0: return
	if $Area2D/Prato/Milho.get_child_count() == 0: return
	$Area2D/Prato/Milho.get_child($Area2D/Prato/Milho.get_child_count() - 1).position = Vector2.ZERO
	$Area2D/Prato/Milho.get_child($Area2D/Prato/Milho.get_child_count() - 1).reparent(mao, false)

func action2(mao):
	if mao.get_child_count() < 1: return
	var milho = mao.get_child(0)
	if !milho.is_in_group("milho"): return
	$TaskTimer.start(3);
	milho.queue_free();

func _on_task_timer_task_ended(result):
	var milho_ralado = MILHO_RALADO.instantiate();
	$Area2D/Prato/Milho.add_child(milho_ralado);
	milho_ralado.global_position = Vector2(20, 0) + global_position;
