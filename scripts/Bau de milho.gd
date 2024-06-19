extends Node2D
@export var total_milhos = 10; 
var highlighted = false;
@onready var milho_com_palha_res = preload("res://scenes/ingredientes/milho_com_palha.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in total_milhos:
		var milho = milho_com_palha_res.instantiate();
		milho.position = Vector2(-10, -10) + Vector2(randf_range(global_position.x - 2,global_position.x + 2), randf_range(global_position.y - 2, global_position.y - 2));
		milho.rotation = randf_range(0, -PI/8);
		$Milhos.add_child(milho);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
