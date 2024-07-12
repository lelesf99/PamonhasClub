extends Node2D
var soundEffect: AudioStreamPlayer2D
var player: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	soundEffect = AudioStreamPlayer2D.new()
	add_child(soundEffect)
	soundEffect.stream = load("res://Trilha Sonora/objetos/embalar.wav")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _play_sound_effect():
	soundEffect.play() 
	
func _input(event):
	if event.is_action_pressed("action") and player and player.position.distance_to(position) < 100.0:
		_play_sound_effect()
