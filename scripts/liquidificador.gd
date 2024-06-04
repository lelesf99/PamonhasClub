extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func put_ingrediente(ingrediente: Node):
	if(is_instance_valid(ingrediente)):
		ingrediente.visible = false;
		ingrediente.reparent($Ingredientes);

func _on_area_2d_body_entered(body):
	if body.is_in_group("player_interaction"):
		$Sprite2D.self_modulate = Color.GAINSBORO;		
		Global.set_highlight(self)


func _on_area_2d_body_exited(body):
	if body.is_in_group("player_interaction"):
		$Sprite2D.self_modulate = Color.WHITE;
		Global.set_highlight(null)
