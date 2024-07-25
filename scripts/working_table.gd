extends Node2D
const hints = [
	{"label": "Pegar/Colocar", "type": "key", "key_label": "1"},
]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Content.get_child_count() > 0:
		for child in $Content.get_children():
			child.global_position = lerp(child.global_position, global_position, 10 * delta);

func action1(mao):
	if mao.get_child_count() != 0:
		var coisa = mao.get_child(0)
		if $Content.get_child_count() == 0:
			coisa.set_disabled(true)
			coisa.reparent($Content)
			return
		else:
			var combo = Global.combine($Content.get_child(0), coisa)
			if combo != null:
				$Content.get_child(0).queue_free()
				coisa.queue_free()
				var instance = combo.instantiate()
				$Content.add_child(instance)
				return
	
	if  mao.get_child_count() == 0 && $Content.get_child_count() != 0:
		if $Content.get_child_count() > 0:
			var coisa = $Content.get_child(0)
			coisa.set_disabled(true)
			coisa.reparent(mao)
			return

func action2():
	pass;
