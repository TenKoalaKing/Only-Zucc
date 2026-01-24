extends Area2D #make big for code to be less complicated
var entered := 0
var rando := 0
var randomized_time_song := 0
var first := 1
var stop_music := 0
#				x_var = 913
#				position = Vector2(x_var, -4622.0)
func _ready() -> void:
	#position = Vector2(913, -3622.0)
	pass




func _on_body_entered(body: Node2D) -> void:
	if (body.name == "zuck_stage_1") or body.is_in_group("player") or (body.name == "Zuck Stage 1"):
		entered = 1
		if first == 1:
			stop_music = 1
			$AudioStreamPlayer.play()
			first = 0
		else:
			randomized_time_song = (randi() % 6 + 1) * 10
			$AudioStreamPlayer.play(randomized_time_song)


func _on_body_exited(body: Node2D) -> void:
	if (body.name == "zuck_stage_1") or body.is_in_group("player") or (body.name == "Zuck Stage 1"):
		entered = 0
		$AudioStreamPlayer.stop()

func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
