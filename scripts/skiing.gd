extends Area2D #make big for code to be less complicated
@onready var zuck = %"Zuck Stage 1"
var entered := 0
var rando := 0
var randomized_time_song := 0
var first := 1
var stop_music := 0
var in_area := 0
var zuck_walking := 0
var previous_zuck_walking := 0
#				x_var = 913
#				position = Vector2(x_var, -4622.0)
func _ready() -> void:
	while 1 == 1:
		while in_area == 1:
			zuck_walking = zuck.moving
			if zuck_walking == 1 and previous_zuck_walking == 0:
				_await_sound_stop()
				$ice_walking.pitch_scale = randf_range(0.8, 1.2)
				$ice_walking.play()
				in_area = 1
				previous_zuck_walking = 1

			elif zuck_walking == 0 and previous_zuck_walking == 1:
				$ice_walking.stop()
				previous_zuck_walking = 0
			await get_tree().process_frame
		if in_area == 0:
			previous_zuck_walking = 0
		await get_tree().process_frame
func _await_sound_stop():
	await wait_time(76.54)
	if in_area == 1:
		previous_zuck_walking = 0




func _on_body_entered(body: Node2D) -> void:
	if (body.name == "zuck_stage_1") or body.is_in_group("player") or (body.name == "Zuck Stage 1"):
		in_area = 1
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
		in_area = 0
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
