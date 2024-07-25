extends Node
var highlighted = null;
var player_stopped = false;
var recipe_map = {
# radicais são primos
	2: preload("res://scenes/ingredientes/milho_com_palha.tscn"),
	3: preload("res://scenes/ingredientes/palha.tscn"),
	5: preload("res://scenes/ingredientes/milho.tscn"),
	7: preload("res://scenes/ingredientes/milho_ralado.tscn"),
	11: "queijo",
	13: "linguica",
# primos a partir de 500 pratos prontos
	503: preload("res://scenes/ingredientes/pamonha_simples.tscn"),
	509: "pamonha_queijo",
	521: "pamonha_moda",
# ------------------------------------
# combinações são produtos
	21: preload("res://scenes/ingredientes/pamonha_simples_crua.tscn"),
	33: "palha_com_queijo",
	77: "milho_ralado_com_queijo",
	231: "pamonha_queijo_crua",
	39: "palha_com_linguica",
	91: "milho_ralado_com_linguica",
	273: "pamonha_moda_crua"
}

var hints = [];

func update_hints(new_hints):
	hints = new_hints;

func combine(ingrediente1, ingrediente2):
	if !is_instance_valid(ingrediente1): return
	if !is_instance_valid(ingrediente2): return
	return recipe_map.get(ingrediente1.ID * ingrediente2.ID)
	
func set_highlight(nodes):
	highlighted = nodes

func get_highlight():
	return highlighted

func stop_player():
	player_stopped = true;

func play_player():
	player_stopped = false;
