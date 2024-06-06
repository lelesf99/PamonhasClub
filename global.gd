extends Node
var highlighted = null;
var player_stopped = false;
var recipe_map = {
# radicais são primos
	2: preload("res://scenes/ingredientes/milho_com_palha.tscn"),
	3: preload("res://scenes/ingredientes/palha.tscn"),
	5: preload("res://scenes/ingredientes/milho.tscn"),
	7: preload("res://scenes/ingredientes/milho_ralado.tscn"),
# primos a partir de 500 pratos prontos
	503: preload("res://scenes/ingredientes/pamonha_simples.tscn"),
	509: "pamonha_queijo",
	521: "pamonha_moda",
# ------------------------------------
# combinações são produtos
	21: preload("res://scenes/ingredientes/pamonha_simples_crua.tscn"),
	165: "pamonha_queijo_crua",
	273: "pamonha_moda_crua"
}

func get_combo(radArray: PackedInt64Array):
	var mult = 1;
	for i in radArray:
		mult = mult * i;
	return recipe_map.get(mult);
func set_highlight(node):
	highlighted = node

func get_highlight():
	return highlighted

func stop_player():
	player_stopped = true;

func play_player():
	player_stopped = false;
	
