extends Area2D
var data

func get_first_interativo():
	for area in get_overlapping_areas():
		if area.is_in_group("interativo"):
			if area.disabled: continue
			return area.get_parent()
