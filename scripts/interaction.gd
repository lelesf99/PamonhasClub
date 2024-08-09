extends Area2D
var data

func get_first_interativo():
	for area in get_overlapping_areas():
		if area.is_in_group("interativo"):
			if area.disabled: continue
			return area.get_parent()

func get_first_segurando():
	var player = get_parent();
	if player.get_node("Mao1").get_child_count() > 0:
		return player.get_node("Mao1").get_child(0)
