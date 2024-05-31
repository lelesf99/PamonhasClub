extends CharacterBody2D

var jogador_proximo = false
var contarMilhos = 0
@onready var PlayerDetector := $PlayerDetector as RayCast2D


func _physics_process(delta):
	if PlayerDetector.is_colliding():
		jogador_proximo = true
	else:
		jogador_proximo = false
		
	if Input.is_action_just_pressed("action") and jogador_proximo:
			contarMilhos = contarMilhos + 1
			if contarMilhos == 2:
				$AnimationPlayer.play("metadeMilhos")
			if contarMilhos == 6:
				$AnimationPlayer.play("ultimosMilhos")
			if contarMilhos == 10:
				$AnimationPlayer.play("acabouMilhos")
			if contarMilhos > 10:
				$AnimationPlayer.play("recarregarMilhos")
				contarMilhos = 0


func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
