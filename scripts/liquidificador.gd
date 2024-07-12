extends Node2D

var soundEffect: AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	soundEffect = AudioStreamPlayer2D.new()
	add_child(soundEffect)
	soundEffect.stream = load("res://Trilha Sonora/objetos/liquidificador.wav")


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
		
func _play_sound_effect():
	soundEffect.play() 
	
func _input(event):
	if event.is_action_pressed("action"): 
		_play_sound_effect()
