extends Area2D
@export var collision_shape: CollisionShape2D
var disabled = false
var hovering = false
# Para usar essa cena, deve-se implementar as funções action1 e action2 no Nó pai

func _process(delta):
	var hovered_por = is_hovered()
	if hovered_por != null && hovering == false:
		print(hovered_por)
		hovering = true;
		modulate = Color.DARK_SALMON;
		if get_parent() is Object and get_parent().has_method("get_hints"):
			print("get_parent().get_hints(hovered_por) is", get_parent().get_hints(hovered_por))
			Global.update_hints(get_parent().get_hints(hovered_por));
		elif get_parent() is Object and "hints" in get_parent():
			print("get_parent().hints is", get_parent().hints)
			Global.update_hints(get_parent().hints);
			
	elif hovered_por == null && hovering == true:
		Global.update_hints([]);
		hovering = false;
		modulate = Color.WHITE

func is_hovered():
	if disabled: return null
	for area in get_overlapping_areas():
		if area.is_in_group("interaction"): 
			if area.get_parent().get_node("Mao1").get_child_count() > 0:
				return area.get_parent().get_node("Mao1").get_child(0)
			else:
				return {}
	return null
