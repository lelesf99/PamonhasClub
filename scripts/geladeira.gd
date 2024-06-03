extends CharacterBody2D

var jogador_proximo = false
var aberta = false
@onready var PlayerDetector := $PlayerDetector as RayCast2D


func _physics_process(delta):
	if PlayerDetector.is_colliding():
		jogador_proximo = true
	else:
		jogador_proximo = false
		if aberta:
			fechar_geladeira()
		
	if Input.is_action_just_pressed("action") and jogador_proximo:
			abrir_geladeira()
		

func abrir_geladeira():
	$AnimationPlayer.play("abrirGeladeira")
	aberta = true

func fechar_geladeira():
	$AnimationPlayer.play("fecharGeladeira")
	aberta = false


func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))
