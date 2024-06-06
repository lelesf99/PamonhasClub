extends Node2D
@export var total_milhos = 10; 
var highlighted = false;
@onready var milho_com_palha_res = preload("res://scenes/milho_com_palha.tscn");


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in total_milhos:
		var milho = milho_com_palha_res.instantiate();
		var rect = $Area2D/CollisionShape2D.shape.get_rect();
		milho.position = Vector2(-10, -10) + Vector2(randf_range(global_position.x - 5,global_position.x + 5), randf_range(global_position.y - 5, global_position.y - 5));
		milho.rotation = randf_range(0, -PI/4);
		$Milhos.add_child(milho);


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

func get_milho():
	print($Milhos.get_child_count())
	return $Milhos.get_child($Milhos.get_child_count() - 1)
