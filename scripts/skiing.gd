extends Area2D
var entered := 0
var rando := 0
#				x_var = 913
#				position = Vector2(x_var, -4622.0)
func _ready() -> void:
	position = Vector2(913, -3622.0)


func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if (body.name == "zuck_stage_1") or body.is_in_group("player") or (body.name == "Zuck Stage 1"):
		entered = 1


func _on_body_exited(body: Node2D) -> void:
	if (body.name == "zuck_stage_1") or body.is_in_group("player") or (body.name == "Zuck Stage 1"):
		if rando == 0:
			rando = 1
			await wait_time(.25)
			entered = 0
			rando = 0


func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
