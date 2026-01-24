extends Node2D
@onready var zuck = %"Zuck Stage 1"
@export var start_path:NodePath
@onready var start_script = get_node(start_path)
var health = 3
var count = 0
var edward_health = 3
var fight := 0
var start = 0
var stuff := 0
func _ready() -> void:
	self.visible = false
func _process(_delta: float) -> void:
	if stuff == 0:
		if count == 0:
			_wait_thingy()
		if health <= 0: #fight == 1 and 
			self.visible = true
			stuff = 1
		elif fight == 0:
			stuff = 1
		if start == 67:
			self.visible = false


func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()

func _wait_thingy():
	fight = zuck.fight
	health = zuck.health
	start = start_script.play
	count = 1
	wait_time(2)
	count = 0
