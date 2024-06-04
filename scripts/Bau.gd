extends Node2D


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


func get_obj():
	if $Content.get_child_count() != 0:
		return $Content.get_child($Content.get_child_count() - 1);
	return null;

func put_obj(obj: Node):
	if is_instance_valid(obj):
		obj.reparent($Content);
		obj.global_position = Vector2(0, -10) + global_position;
		obj.rotate(randf_range(-PI/8, PI/8));

func add_obj(obj: Node):
	if is_instance_valid(obj):
		$Content.add_child(obj);
		obj.global_position = Vector2(0, -10) + global_position;
		obj.rotate(randf_range(-PI/8, PI/8));
		
