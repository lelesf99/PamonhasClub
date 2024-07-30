extends Area2D
@export var collision_shape: CollisionShape2D
var disabled = false
var hovering = false
# Para usar essa cena, deve-se implementar as funções action1 e action2 no Nó pai

func _process(delta):
	if is_hovered() && hovering == false:
		hovering = true;
		modulate = Color.DARK_SALMON;
		if get_parent() is Object and "hints" in get_parent():
			Global.update_hints(get_parent().hints);
	elif !is_hovered() && hovering == true:
		Global.update_hints([]);
		hovering = false;
		modulate = Color.WHITE

func is_hovered():
	if disabled: return false
	for area in get_overlapping_areas():
		if area.is_in_group("interaction"): 
			return true
	return false
