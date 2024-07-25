extends CanvasLayer
const HINT = preload("res://scenes/hint.tscn")
var hints = [];

# Called when the node enters the scene tree for the first time.
func _ready():
	update_hints();

func update_hints():
	for hint in $Hints.get_children():
		hint.queue_free();
	for hint in hints:
		var new_hint = HINT.instantiate();
		new_hint.type = hint.type;
		new_hint.label = hint.label;
		new_hint.key_label = hint.key_label;
		$Hints.add_child(new_hint);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass;
