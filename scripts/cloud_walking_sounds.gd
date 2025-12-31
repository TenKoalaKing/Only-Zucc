extends Area2D
@onready var zuck = %"Zuck Stage 1"
var in_area = 0
var zuck_walking = 0
var previous_zuck_walking = 0

func _on_body_entered(body: Node2D) -> void:
	# DEBUG PRINT: This proves the signal is working
	print("Body entered: ", body.name) 
	
	if (body.name == "zuck_stage_1") or body.is_in_group("player") or (body.name == "Zuck Stage 1"):
		in_area = 1
	else:
		# DEBUG PRINT: This proves the logic failed
		print("Body entered but logic failed. Groups: ", body.get_groups())

func _on_body_exited(body: Node2D) -> void:
	if (body.name == "zuck_stage_1") or body.is_in_group("player") or (body.name == "Zuck Stage 1"):
		$AudioStreamPlayer.stop()
		in_area = 0

func _ready() -> void:
	while 1 == 1:
		while in_area == 1:
			zuck_walking = zuck.moving
			if zuck_walking == 1 and previous_zuck_walking == 0:
				_await_sound_stop()
				$AudioStreamPlayer.pitch_scale = randf_range(0.8, 1.2)
				$AudioStreamPlayer.play()
				in_area = 1
				previous_zuck_walking = 1
			elif zuck_walking == 0 and previous_zuck_walking == 1:
				$AudioStreamPlayer.stop()
				previous_zuck_walking = 0
			await get_tree().process_frame
		if in_area == 0:
			previous_zuck_walking = 0
		await get_tree().process_frame
func _await_sound_stop():
	await wait_time(1.54)
	if in_area == 1:
		previous_zuck_walking = 0
func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
