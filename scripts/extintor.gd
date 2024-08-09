extends Node2D
var emitting = false
const FUMACA = preload("res://scenes/objetos/fumaca.tscn")
@export var emit_rate = 5
var emit_timer = 1.0
# Called when the node enters the scene tree for the first time.
func _ready():
	emit_timer = 1.0/emit_rate
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	emit_timer = emit_timer - delta
	if emitting and emit_timer <= 0:
		emit_timer = 1.0/emit_rate
		var fumaca = FUMACA.instantiate()
		var mao = get_parent()
		fumaca.global_position = $Emitter.global_position
		fumaca.linear_velocity = randf_range(50, 100) * mao.get_parent().global_position.direction_to(mao.get_parent().get_node("Interaction").global_position).rotated(randf_range(-PI/16, PI/16))
		get_tree().root.add_child(fumaca)


func action1(mao2D):
	global_position = mao2D.global_position
	rotation = 0
	if mao2D.get_child_count() == 0:
		set_disabled(true)
		emitting = true
		reparent(mao2D)
	else:
		set_disabled(false)
		emitting = false
		reparent(get_tree().root)

func action2(mao2D):
	pass # Replace witha ation2 code

func set_disabled(value: bool):
	$Interativo.disabled = value

