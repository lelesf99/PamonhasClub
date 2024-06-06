extends Node2D
const MILHO_RALADO = preload("res://scenes/ingredientes/milho_ralado.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	if body.is_in_group("player_interaction"):
		$Sprite2D.self_modulate = Color.GAINSBORO;		
		Global.set_highlight(self)


func _on_area_2d_body_exited(body):
	if body.is_in_group("player_interaction"):
		$Sprite2D.self_modulate = Color.WHITE;
		Global.set_highlight(null)

func ralar_milho(milho: Node):
	if is_instance_valid(milho) && milho.is_in_group("milho"):
		$TaskTimer.start(3);
		milho.queue_free();

func get_milho():
	return $Prato/Milho.get_child($Prato/Milho.get_child_count() - 1)


func _on_task_timer_task_ended(result):
	print(result)
	var milho_ralado = MILHO_RALADO.instantiate();
	$Prato/Milho.add_child(milho_ralado);
	milho_ralado.global_position = Vector2(20, 0) + global_position;
