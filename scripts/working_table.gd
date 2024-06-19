extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func action1(mao):
	print(mao.get_child_count() != 0, $Content.get_child_count() == 0)
	if mao.get_child_count() != 0:
		var coisa = mao.get_child(0)
		if $Content.get_child_count() == 0:
			coisa.set_disabled(true)
			coisa.reparent($Content, false)
			return
		else:
			var combo = Global.combine($Content.get_child(0), coisa)
			if combo != null:
				$Content.get_child(0).queue_free()
				coisa.queue_free()
				var instance = combo.instantiate()
				$Content.add_child(instance)
				instance.global_position = $Content.global_position
				return
	
	if  mao.get_child_count() == 0 && $Content.get_child_count() != 0:
		if $Content.get_child_count() > 0:
			var coisa = $Content.get_child(0)
			coisa.global_position = mao.global_position
			coisa.set_disabled(true)
			coisa.reparent(mao)
			return
