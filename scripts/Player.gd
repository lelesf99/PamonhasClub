extends CharacterBody2D
const SPEED = 200.0
@onready var sprite = $Sprite2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if velocity != Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("walk");
		$AnimationTree.set("parameters/idle/blend_position", velocity.normalized());
		$AnimationTree.set("parameters/walk/blend_position", velocity.normalized());
	else:
		$AnimationTree.get("parameters/playback").travel("idle");
		
		
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("move_left", "move_right");
	var directionY = Input.get_axis("move_up", "move_down");
	if directionX || directionY:
		velocity = Vector2(directionX, directionY).normalized() * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()



