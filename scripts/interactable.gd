extends Area2D
@export var collision_shape: CollisionShape2D
var disabled = false
# Para usar essa cena, deve-se implementar as funções action1 e action2 no Nó pai

func _process(delta):
	if is_hovered():
		modulate = Color.DARK_SALMON
	else:
		modulate = Color.WHITE

func is_hovered():
	if disabled: return false
	for area in get_overlapping_areas():
		if area.is_in_group("interaction"): return true
	return false
