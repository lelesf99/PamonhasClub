extends CharacterBody2D

var jogador_proximo = false
var contarPanelas = 0
@onready var PlayerDetector := $PlayerDetector as RayCast2D


func _physics_process(delta):
	if PlayerDetector.is_colliding():
		jogador_proximo = true
	else:
		jogador_proximo = false
		
	if Input.is_action_just_pressed("action") and jogador_proximo:
			contarPanelas = contarPanelas + 1
			if contarPanelas == 1:
				$AnimationPlayer.play("NovaPanela")
			if contarPanelas == 2:
				$AnimationPlayer.play("SegundaPanela")
			if contarPanelas > 2:
				$AnimationPlayer.play("RESET")
				contarPanelas = 0


func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
