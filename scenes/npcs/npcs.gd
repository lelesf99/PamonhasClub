extends CharacterBody2D

const speed = 200.0
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var direction : Vector2
var timer_status = 0;
@onready var dialog = get_node("Dialogo")
@onready var bg = get_node("Dialogo/Control/ItemList")
# direction and animation to be updated throughout game state
var new_direction = Vector2(0,1)

func _physics_process(delta):
	return

func _on_timer_timeout():
	if(timer_status == 0):
		timer_status += 1
		dialog.visible = true
	if(timer_status == 5):
		timer_status += 1
		var theme = bg.get_theme_stylebox("panel")
		theme.set("bg_color", Color.YELLOW)
	if(timer_status == 15):
		timer_status += 1
		var theme = bg.get_theme_stylebox("panel")
		theme.set("bg_color", Color.RED)
	if(timer_status == 20):
		timer_status += 1
		dialog.visible = false
	timer_status += 1
