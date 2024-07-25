extends Node2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var target_position = Vector2.ZERO
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = get_node("../AnimatedSprite2D") 
@export var speed = 200
var velocity = Vector2.ZERO
func _physics_process(delta):
	var direction = (target_position - position).normalized()
	var distance_to_target = position.distance_squared_to(target_position)

	if distance_to_target > 1.0:
		velocity = direction * speed
		#animated_sprite.play("run_up")  # Inicia a animação de corrida
	else:
		velocity = Vector2.ZERO
		animated_sprite.play("idle_up")  # Para a animação quando chega ao destino

	# Aplicar o movimento
	position += velocity * delta

	# Inverter o sprite horizontalmente se necessário
	if direction.x < 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
