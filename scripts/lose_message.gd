extends Node2D
@onready var zuck = %"Zuck Stage 1"
@export var start_path:NodePath
@onready var start_script = get_node(start_path)
var health = 3
var count = 0
var edward_health = 3
var fight
var start = 0
func _ready() -> void:
	self.visible = false
	while count == 0:
		await wait_time(.25)
		fight = zuck.fight
		health = zuck.health
		if fight == 1 and health <= 0:
			self.visible = true
			count = 2
		start = start_script.play
		if start == 67:
			self.visible = false
			count = 0

func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
