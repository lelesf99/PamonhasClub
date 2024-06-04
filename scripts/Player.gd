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

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var directionX = Input.get_axis("move_left", "move_right");
	var directionY = Input.get_axis("move_up", "move_down");
	if directionX || directionY:
		velocity = Vector2(directionX, directionY).normalized() * SPEED;
		$Interaction.rotation = velocity.angle()  - PI/2;
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
	
	if Input.is_action_just_pressed("item_2"):
		if Global.get_highlight():
			if Global.get_highlight().is_in_group("mesa_despalha"):
				Global.get_highlight().despalhar_milho()
				
	if Input.is_action_just_pressed("item_1"):
		if Global.get_highlight(): 
			if(Global.get_highlight().is_in_group("liquidificador")):
				if($Mao1.get_child_count() == 1):
					Global.get_highlight().put_ingrediente($Mao1.get_child(0));
			
			if Global.get_highlight().is_in_group("bau_generico"):
				if $Mao1.get_child_count() == 0: 
					var coisa = Global.get_highlight().get_obj();
					if is_instance_valid(coisa):
						coisa.global_position = $Mao1.global_position + Vector2(-10, -10);
						coisa.rotation = 0;
						coisa.reparent($Mao1);
			
			if Global.get_highlight().is_in_group("mesa_despalha"):
				if($Mao1.get_child_count() == 1):
					if $Mao1.get_child(0).is_in_group("milho_com_palha"):
						Global.get_highlight().put_milho($Mao1.get_child(0));
			
			if Global.get_highlight().is_in_group("bau_de_milho"):
				if $Mao1.get_child_count() == 0: 
					var milho = Global.get_highlight().get_milho();
					milho.global_position = $Mao1.global_position + Vector2(-10, -10);
					milho.rotation = 0;
					Global.get_highlight().get_milho().reparent($Mao1);
