extends CharacterBody2D
@onready var game_manager = %"Game Manager"
var counter = 0
func _ready():
	while counter < 1:
		await wait_time(2)
		var score = game_manager.score
		if score >= 1:
			self.visible = false
			$CollisionShape2D.disabled = true
			counter = 5
func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
