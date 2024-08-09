extends Node2D

enum Pamonha { QUEIJO, SIMPLES }

var icones_pamonha: Array[AnimatedSprite2D];
@onready var sprite_pamonha = $sprite_pamonha
var pedido: Pamonha = -1  

func _ready():
	icones_pamonha = [$AnimatedSprite2D, $AnimatedSprite2D2]
	gerar_pedido()

func gerar_pedido():
	pedido = randi() % Pamonha.size()   
	for i in Pamonha.size():
		var icone = icones_pamonha[i]
		if i == pedido:
			icone.visible = true;
		else:
			icone.visible = false;
