extends Area2D
@onready var zuck = %"Zuck Stage 1"
var in_area = 0
var zuck_walking = 0
var previous_zuck_walking = 0
var finished = 1
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

func _process(_delta: float) -> void:
	if in_area == 1:
		finished = 1
