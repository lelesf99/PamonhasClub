extends Node2D
@export var total_queijos = 100; 
var highlighted = false;
@onready var queijo_res = preload("res://scenes/ingredientes/queijo.tscn");


# Called when the node enters the scene tree for the first time.
func _ready():
	for i in total_queijos:
		var queijo = queijo_res.instantiate();
		queijo.position = Vector2(-10, -10) + Vector2(randf_range(global_position.x - 2,global_position.x + 2), randf_range(global_position.y - 2, global_position.y - 2));
		queijo.rotation = randf_range(0, -PI/8);
		$Queijos.add_child(queijo);


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
