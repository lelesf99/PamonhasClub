extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.is_in_group("player_interaction"):
		self_modulate = Color.GAINSBORO;		
		Global.set_highlight(self)

func _on_area_2d_body_exited(body):
	if body.is_in_group("player_interaction"):
		self_modulate = Color.WHITE;
		Global.set_highlight(null)

func get_obj():
	if $Content.get_child_count() != 0:
		return $Content.get_child($Content.get_child_count() - 1);
	return null;

func put_obj(obj: Node):
	if is_instance_valid(obj):
		if($Content.get_child_count() < 1):
			obj.reparent($Content);
			obj.global_position = global_position;
		else:
			var map = [];
			for node in $Content.get_children():
				print(node.ID)
				map.push_back(node.ID);
			map.push_back(obj.ID);
			var combo = Global.get_combo(map);
			if combo:
				for node in $Content.get_children():
					node.queue_free();
				obj.queue_free();
				var nova_coisa = combo.instantiate();
				$Content.add_child(nova_coisa);
				nova_coisa.global_position = global_position;
