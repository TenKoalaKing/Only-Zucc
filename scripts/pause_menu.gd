extends Node2D
var current_func = 0
var esc = 0
var enter = 0
var reset = 0
@onready var top = $Top
@onready var bottom = $Bottom
@export var camera_2d_path:NodePath
@onready var camera = get_node(camera_2d_path)



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	top.hide()
	bottom.hide()
	
func _input(event):
	if event.is_action_pressed("esc"):
		esc = 1
		if current_func == 0:
			_main_func()
	if event.is_action_pressed("enter"):
		enter = 1
		if current_func == 0:
			_main_func()
func _main_func():
	esc = 0
	current_func = 1
	top.show()
	bottom.show()
	while current_func == 1:
		if esc == 1:
			top.hide()
			bottom.hide()
			esc = 0
			current_func = 0
			pass
		if enter == 1:
			bottom.hide()
			top.hide()
			reset = 1
			await wait_time(1.3)
			current_func = 0
			reset = 0
		await wait_time(.1)
func _process(_delta):
	global_position = camera.get_screen_center_position()

func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
