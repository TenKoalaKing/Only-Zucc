extends Node2D
@export var edward_path:NodePath
@onready var edward_script = get_node(edward_path)
@onready var zuck = %"Zuck Stage 1"
@export var start_path:NodePath
@onready var start_script = get_node(start_path)
var health = 3
var count = 0
var edward_health = 3
var fight = 0
var start = 0
var zuck_win = 0
func _ready() -> void:
	self.visible = false
func _process(_delta: float) -> void:
	fight = zuck.fight
	zuck_win = zuck.zuck_win
	if fight == 1 and zuck_win == 1:
		self.visible = true
		count = 2
	start = start_script.play
	if start == 67:
		self.visible = false
		count = 0
		zuck_win = 0
func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
