extends Button

@export var scene_path: String

func _ready():
	self.pressed.connect(_on_botao_voltar_pressed)
	self.mouse_entered.connect(_on_mouse_entered)
	self.mouse_exited.connect(_on_mouse_exited)
	
func _on_botao_voltar_pressed():
	var _change_scene: bool = get_tree().change_scene_to_file(scene_path)


func _on_mouse_exited():
	self.modulate.a = 1.0


func _on_mouse_entered():
	self.modulate.a = 0.5
