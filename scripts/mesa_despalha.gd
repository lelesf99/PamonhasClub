extends Node2D
var highlighted = false;
const MILHO = preload("res://scenes/milho.tscn")
const PALHA = preload("res://scenes/palha.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


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

func put_milho(milho):
	if milho:
		if milho.is_in_group("milho_com_palha"):
			milho.global_position = global_position + Vector2(-10, -10);
			milho.reparent($MilhoComPalha);

func despalhar_milho():
	if $MilhoComPalha.get_child_count() != 0:
		var milho = $MilhoComPalha.get_child(0);
		milho.queue_free();
		$BauMilho.add_obj(MILHO.instantiate());
		$BauPalha.add_obj(PALHA.instantiate());
		
