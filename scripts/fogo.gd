extends Node2D
@export var vida = 10
const FIRE_PARTICLES = preload("res://scenes/objetos/fire_particles.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_area_entered(area):
	print(area.is_in_group("fumaca_extintor"))
	if area.is_in_group("fumaca_extintor"):
		var particles = FIRE_PARTICLES.instantiate()
		particles.emitting = true
		$".".add_child(particles)
		vida = vida - 1;
		if vida < 0:
			queue_free()
	pass # Replace with function body.
