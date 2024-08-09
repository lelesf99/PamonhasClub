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
var primeira_pamonha_entregue = false
@onready var livro_receitas = $LivroReceitas
@onready var timer_game = $timer_game


func _ready():
	cliente_scenes.push_back(AdamScene)
	cliente_scenes.push_back(AlexScene)
	cliente_scenes.push_back(AmeliaScene)
	cliente_scenes.push_back(BobScene)
	
	posicao_balcao = fila_balcao.position
	_on_timer_cliente_timeout()
	if not primeira_pamonha_entregue:
		_novo_cliente()
	
	
func _process(delta):
	if Input.is_action_just_pressed("livro_receitas"):
		livro_receitas.visible = !livro_receitas.visible;
		
	if Global.hints != $ActionHints.hints:
		$ActionHints.hints = Global.hints;
		$ActionHints.update_hints()
		print($ActionHints.hints)

func _on_timer_cliente_timeout():
	if primeira_pamonha_entregue:
		var random_index = randi() % cliente_scenes.size()
		var cliente_scene = cliente_scenes[random_index]
		var new_client = cliente_scene.instantiate()
		add_child(new_client)
	
		# Cria e configura o balão de diálogo
		var balao_dialogo = load("res://scenes/balao_dialogo.tscn").instantiate()  # Carregue sua cena do balão
		new_client.add_child(balao_dialogo)
		balao_dialogo.position = Vector2(0, -35)  
	
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
	
func _next_from_queue():
	if not primeira_pamonha_entregue:
		primeira_pamonha_entregue = true
	
	var cliente = clientes_na_fila.pop_front()
	cliente.queue_free()
	_atualizar_fila_apos_entrega()

func _atualizar_fila_apos_entrega():
	clientes_na_fila.sort_custom(Callable(self, "_comparar_clientes_por_distancia"))
	var direcao_fila = Vector2.ZERO
	direcao_fila.y = sign(posicao_balcao.y + posicao_fila.y)

	for i in range(clientes_na_fila.size()):
		var cliente = clientes_na_fila[i]
		if i == 0:
			cliente.position = posicao_balcao # Primeiro cliente vai para o balcão
		else:
			cliente.position = clientes_na_fila[i-1].position + direcao_fila * distancia_fila  # Pega a posição do cliente da frente

	if not clientes_na_fila.is_empty():
		posicao_fila = clientes_na_fila[-1].position + direcao_fila * distancia_fila
		
func _novo_cliente():
	var random_index = randi() % cliente_scenes.size()
	var cliente_scene = cliente_scenes[random_index]
	var new_client = cliente_scene.instantiate()
	add_child(new_client)
	
	# Cria e configura o balão de diálogo
	var balao_dialogo = load("res://scenes/balao_dialogo.tscn").instantiate()  # Carregue sua cena do balão
	new_client.add_child(balao_dialogo)
	balao_dialogo.position = Vector2(0, -35)  
	
	if clientes_na_fila.is_empty():  
		new_client.position = posicao_balcao  
	add_child(new_client)
	clientes_na_fila.append(new_client)

func save():
	var save_file = FileAccess.open("user://savegame.save", FileAccess.WRITE)
	var json_string = JSON.stringify({"score": $UICanva2/UI/ScoreLabel.score})
	# Store the save dictionary as a new line in the save file.
	save_file.store_line(json_string)


	
func _on_timer_game_timeout():
	save();
	get_tree().change_scene_to_file("res://scenes/menu.tscn")
#Carregar tela de fim de jogo
