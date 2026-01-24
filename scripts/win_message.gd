extends Node2D
#@export var edward_path:NodePath
#@onready var edward_script = get_node(edward_path)
@onready var zuck = %"Zuck Stage 1"
@export var start_path:NodePath
@onready var start_script = get_node(start_path)
var health = 3
var edward_health = 3
var fight = 0
var start = 0
var zuck_win = 0
var count := 0
var stuff := 0
func _ready() -> void:
	self.visible = false
func _process(_delta: float) -> void:
	if stuff == 0:
		if count == 0:
			_wait_thingy()

		if edward_health <= 0:
			if health >= edward_health:
				self.visible = true
		if start == 67:
			self.visible = false
			zuck_win = 0
func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
func _wait_thingy():
	count = 1
	fight = zuck.fight
	zuck_win = zuck.zuck_win
	health = zuck.health
	edward_health = zuck.edward_health
	start = start_script.play
	await wait_time(.2)
	count = 0
