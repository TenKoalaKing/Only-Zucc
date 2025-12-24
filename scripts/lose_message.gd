extends Node2D
@onready var zuck = %"Zuck Stage 1"
var health = 3
var count = 0
var edward_health = 3
func _ready() -> void:
	self.visible = false
	while count == 0:
		await wait_time(.25)
		health = zuck.health
		if health <= 0:
			self.visible = true
			count = 2

func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
