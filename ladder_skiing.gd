extends Node2D
var zuck_on_ladder := 0
var started_climbing := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "zuck_stage_1") or body.is_in_group("player") or (body.name == "Zuck Stage 1"):
		zuck_on_ladder = 1
		started_climbing = 1
		if not $AudioStreamPlayer.playing:
			$AudioStreamPlayer.play(1.5)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if (body.name == "zuck_stage_1") or body.is_in_group("player") or (body.name == "Zuck Stage 1"):
		zuck_on_ladder = 0
		if $AudioStreamPlayer.playing:
			$AudioStreamPlayer.stop()
