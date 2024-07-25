extends Node2D
# Quatro cenas de clientes
@export var AdamScene: PackedScene
@export var AlexScene: PackedScene
@export var AmeliaScene: PackedScene
@export var BobScene: PackedScene

@onready var timer_cliente = $TimerCliente
var cliente_scenes = []

@export var posicao_fila = Vector2()

var target_position = Vector2()
var clientes_na_fila = []
var distancia_fila = 40
@export var posicao_balcao = Vector2.ZERO
@onready var fila_balcao = $FilaBalcao

func _ready():
	cliente_scenes.push_back(AdamScene)
	cliente_scenes.push_back(AlexScene)
	cliente_scenes.push_back(AmeliaScene)
	cliente_scenes.push_back(BobScene)
	
	posicao_balcao = fila_balcao.position
	
func _process(delta):
	if Global.hints != $ActionHints.hints:
		$ActionHints.hints = Global.hints;
		$ActionHints.update_hints()
		print($ActionHints.hints)

func _on_timer_cliente_timeout():
	var random_index = randi() % cliente_scenes.size()
	var cliente_scene = cliente_scenes[random_index]
	var new_client = cliente_scene.instantiate()
	add_child(new_client)
	
	if clientes_na_fila.is_empty():  
		new_client.position = posicao_balcao  
	else:
		new_client.position = posicao_fila  
	add_child(new_client)
	clientes_na_fila.append(new_client)
	_atualizar_posicoes_na_fila()
	
func _atualizar_posicoes_na_fila():
	clientes_na_fila.sort_custom(Callable(self, "_comparar_clientes_por_distancia"))
	var direcao_fila = Vector2.ZERO
	direcao_fila.y = sign(posicao_balcao.y + posicao_fila.y)  
	
	for i in range(clientes_na_fila.size()):
		var cliente = clientes_na_fila[i]
		var movimento_script = cliente.get_node("MovimentoCliente")
		if movimento_script:
			if i == 0:
				movimento_script.target_position = posicao_balcao  # Primeiro cliente no balcão
			else:
				var cliente_da_frente = clientes_na_fila[i - 1]
				movimento_script.target_position = cliente_da_frente.position + direcao_fila * distancia_fila
	if not clientes_na_fila.is_empty():
		posicao_fila = clientes_na_fila[-1].position + direcao_fila * distancia_fila
 
func _comparar_clientes_por_distancia(a, b):
	var distancia_a = a.position.distance_squared_to(posicao_balcao)
	var distancia_b = b.position.distance_squared_to(posicao_balcao)
	return distancia_a < distancia_b
