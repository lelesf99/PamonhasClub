extends Area2D
@export var life_time = 0.5
var linear_velocity = Vector2.ZERO
# Called when the node enters the scene tree for the first time.
func _ready():
	scale = Vector2.ONE * randf_range(0.5, 1.5)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	global_position = global_position + linear_velocity * delta
	life_time = life_time - delta
	if life_time <= 0:
		queue_free()
	pass
