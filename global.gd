extends Node
var highlighted = null;
var player_stopped = false;
var recipe_map = {
# radicais são primos
	2: preload("res://scenes/ingredientes/milho_com_palha.tscn"),
	3: preload("res://scenes/ingredientes/palha.tscn"),
	5: preload("res://scenes/ingredientes/milho.tscn"),
	7: preload("res://scenes/ingredientes/milho_ralado.tscn"),
	11: preload("res://scenes/ingredientes/queijo.tscn"),
	13: preload("res://scenes/ingredientes/queijo_cortado.tscn"),
# primos a partir de 500 pratos prontos
	503: preload("res://scenes/ingredientes/pamonha_simples.tscn"),
	509: preload("res://scenes/ingredientes/pamonha_queijo.tscn"),
	521: "pamonha_moda",
# ------------------------------------
# combinações são produtos
	21: preload("res://scenes/ingredientes/pamonha_simples_crua.tscn"),
	39: preload("res://scenes/ingredientes/palha_com_queijo_cortado.tscn"),
	91: preload("res://scenes/ingredientes/milho_ralado_com_queijo_cortado.tscn"),
	273: preload("res://scenes/ingredientes/pamonha_queijo_crua.tscn"),
}

var hints = [];
var best;

func update_hints(new_hints):
	hints = new_hints;

func combine(ingrediente1, ingrediente2):
	if !is_instance_valid(ingrediente1): return
	if !is_instance_valid(ingrediente2): return
	print(ingrediente1.ID,ingrediente2.ID,ingrediente1.ID * ingrediente2.ID)
	return recipe_map.get(ingrediente1.ID * ingrediente2.ID)
	
func set_highlight(nodes):
	highlighted = nodes

func get_highlight():
	return highlighted

func stop_player():
	player_stopped = true;

func play_player():
	player_stopped = false;

func set_best(new_best):
	best = new_best
func get_best():
	if not FileAccess.file_exists("user://savegame.save"):
		return # Error! We don't have a save to load.

	# Load the file line by line and process that dictionary to restore
	# the object it represents.
	var save_file = FileAccess.open("user://savegame.save", FileAccess.READ)
	var scores = [] 
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()

		# Creates the helper class to interact with JSON
		var json = JSON.new()

		# Check if there is any error while parsing the JSON string, skip in case of failure
		var parse_result = json.parse(json_string)
		if not parse_result == OK:
			print("JSON Parse Error: ", json.get_error_message(), " in ", json_string, " at line ", json.get_error_line())
			continue

		# Get the data from the JSON object
		var score = json.get_data()
		scores.append(score.score)
	var max_score = -100000;
	for scr in scores:
		max_score = max(max_score, scr)
	return max_score;
