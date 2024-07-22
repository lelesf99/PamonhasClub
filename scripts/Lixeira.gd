extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Content.get_child_count() > 0:
		for child in $Content.get_children():
			child.global_position = lerp(child.global_position, global_position, 10 * delta);
			if global_position.distance_squared_to(child.global_position) < 1:
				child.queue_free();

func action1(mao2D):
	if mao2D.get_child_count() != 0:
		if $Content.get_child_count() == 0:
			var coisa = mao2D.get_child(0)
			coisa.reparent($Content);

func action2(mao2D):
	pass # Replace witha ation2 code

func set_disabled(value: bool):
	$Interativo.disabled = value
