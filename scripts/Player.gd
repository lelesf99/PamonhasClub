extends CharacterBody2D
const SPEED = 200.0
@onready var sprite = $Sprite2D
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if Global.player_stopped: return;
	if velocity != Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("walk");
		$AnimationTree.set("parameters/idle/blend_position", velocity.normalized());
		$AnimationTree.set("parameters/walk/blend_position", velocity.normalized());
	else:
		$AnimationTree.get("parameters/playback").travel("idle");

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("move_left", "move_right");
	var directionY = Input.get_axis("move_up", "move_down");
	if directionX || directionY:
		velocity = Vector2(directionX, directionY).normalized() * SPEED;
		$Interaction.position = Vector2(directionX, directionY) * 32 + Vector2(0.0, 8.0);
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	if Input.is_action_just_pressed("item_1"):
		var interativo = $Interaction.get_first_interativo()
		if interativo != null:
			interativo.action1($Mao1)
		else:
			if $Mao1.get_child_count() > 0:
				$Mao1.get_child(0).action1($Interaction)
	if Input.is_action_just_pressed("item_2"):
		var interativo = $Interaction.get_first_interativo()
		if interativo != null:
			interativo.action2($Mao1)
