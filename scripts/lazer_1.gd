extends Node2D #for number 1 of senate part 1
var zuck_in_zone := 0
var senate_in_zone := 0
var prev_senate_in_zone := 0
var hit := 0
func _ready() -> void:
	self.visible = false
func _process(_delta: float) -> void:
	if senate_in_zone == 1 and prev_senate_in_zone == 0:
		prev_senate_in_zone = 1
		self.visible = true
	else:
		prev_senate_in_zone = 0
		self.visible = false
	#if senate_in_zone == 1 and zuck_in_zone == 1:
	#	hit = 1
	#	_resets()
#func _resets():
#	await wait_time(.25)
#	hit = 0
func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()



func _on_sense_senate_body_entered(_body: Node2D) -> void:
	senate_in_zone = 1
	

func _on_sense_senate_body_exited(_body: Node2D) -> void:
	senate_in_zone = 0


func _on_sense_zuck_body_entered(body: Node2D) -> void:
	if (body.name == "zuck_stage_1") or body.is_in_group("player") or (body.name == "Zuck Stage 1"):
		if zuck_in_zone == 0 and senate_in_zone == 1:
			_entered_zone()



func _entered_zone():
	zuck_in_zone = 1
	await wait_time(.5)
	zuck_in_zone = 0
