extends Area2D

func _ready() -> void:
	$AudioStreamPlayer.stop()

func _on_body_entered(body: Node2D) -> void:
	# DEBUG PRINT: This proves the signal is working
	print("Body entered: ", body.name) 
	
	if (body.name == "zuck_stage_1") or body.is_in_group("player") or (body.name == "Zuck Stage 1"):
		print(body.name)
		$AudioStreamPlayer.play()
		print("played")
	else:
		# DEBUG PRINT: This proves the logic failed
		print("Body entered but logic failed. Groups: ", body.get_groups())

func _on_body_exited(body: Node2D) -> void:
	if (body.name == "zuck_stage_1") or body.is_in_group("player") or (body.name == "Zuck Stage 1"):
		$AudioStreamPlayer.stop()
		print("stopped")
