extends Node

signal score_changed(new_score)

var score = 0:
	set(value):
		if score != value:  # Only emit if actually changed
			score = value
			print("Score changed to: ", score)
			score_changed.emit(score)

func add_point():
	score += 1
var counter = 0
func _ready():
	while counter < 1:
		await wait_time(2)
		print("tick tock from game manager")
		if score >= 1:
			print("works on game_managers end")
			counter = 5


func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
