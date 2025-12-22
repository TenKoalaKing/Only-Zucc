extends Node
signal score_changed(new_score)
var score = 0:
	set(value):
		if score != value:  # Only emit if actually changed
			score = value
			score_changed.emit(score)

func add_point():
	score += 1
var counter = 0
