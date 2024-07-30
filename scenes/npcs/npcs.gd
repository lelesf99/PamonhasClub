extends CharacterBody2D
var hints = [
	{"label": "Entregar", "type": "key", "key_label": "1"}
]
@onready var score = get_node("/root/Main/UICanva/UI/ScoreLabel")
@onready var main = get_node("/root/Main")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func action1(mao):
	if mao.get_child_count() != 0:
		var coisa = mao.get_node_or_null('PamonhaSimples')
		if coisa != null:
			score.update_score()
			coisa.queue_free()
			main._next_from_queue()
	pass

func action2(mao):
	pass
