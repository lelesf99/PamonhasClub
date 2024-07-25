extends Control
const KEYCAP_64 = preload("res://assets/keycap.png");
@export var label = "Abrir";
@export var texture = KEYCAP_64;
@export var type = "key";
@export var key_label = "1";
# Called when the node enters the scene tree for the first time.

func _ready():
	if type == "key":
		$Icon.texture = KEYCAP_64;
		$Label.text = label;
		$keyLabel.text = key_label;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass;
