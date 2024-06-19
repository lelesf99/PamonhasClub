extends Node2D
signal task_ended(result);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func pause():
	$Timer.paused = true;
	$AnimationPlayer.pause();

func resume():
	$Timer.paused = false;
	$AnimationPlayer.play();
	
func start(time, async = false, overtime = null):
	if !async :
		Global.stop_player();
	$Timer.wait_time = time + 0.01;
	$Timer.start();
	$AnimationPlayer.play("task", -1, 1.0/time);
	$Timer.timeout.connect(on_task_timeout.bind(overtime), CONNECT_ONE_SHOT);

func on_task_timeout(overtime):
	Global.play_player();
	if overtime:
		$Timer.wait_time = overtime + 0.01;
		$AnimationPlayer.play("overtime", -1, 1.0/overtime);
		task_ended.emit("task_finished");
	else:
		task_ended.emit("success");
	
func conclude_task():
	if $AnimationPlayer.current_animation == "task":
		pause();
	elif $AnimationPlayer.current_animation == "overtime":
		if $Timer.time_left > 0:
			$Overtimer_sprite.visible = false;
			task_ended.emit("success");
		else:
			$Overtimer_sprite.visible = false;
			task_ended.emit("fail");