extends Node2D

enum Pamonha { MODA, QUEIJO, SIMPLES }

@export var icones_pamonha: Array[Texture2D]  
@onready var sprite_pamonha = $sprite_pamonha
var pedido: Pamonha = -1  

func _ready():
	gerar_pedido()

func gerar_pedido():
	pedido = randi() % Pamonha.size()   
	sprite_pamonha.texture = icones_pamonha[pedido]
