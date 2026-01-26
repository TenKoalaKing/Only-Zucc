extends ColorRect

@export var zuck_script: NodePath
@onready var zuck = get_node(zuck_script)

@export var mic_for_senate_script: NodePath
@onready var mic_for_senate = get_node(mic_for_senate_script)

@export var ladder1_script: NodePath
@onready var ladder1 = get_node(ladder1_script)

@export var start_script_path: NodePath
@onready var start_script = get_node(start_script_path)

var started_climbing := 0
var finished_mic := false
var prev_climb := 0
var prev_finished_mic := false
var start_sequence_done := 0
var color_blue
var change_r := 0.1
var change_g := 0.1
var change_b := 0.1
var first_run := 0
var skiing := 0
var prev_skiing := 0
var test_skiing := 0
var flashing_red := 0
func _ready() -> void:
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	color = Color(0.386, 0.386, 0.386, 1.0)
	color_blue = Color(0.195, 0.584, 0.93, 1.0)
	change_r = color_blue.r
	change_g = color_blue.g
	change_b = color_blue.b

func _process(_delta: float) -> void:
	start_sequence_done = zuck.sdajfksdfl_camera_start_sequence_done
	started_climbing = ladder1.started_climbing
	finished_mic = mic_for_senate.finished
	skiing = zuck.skiing
	if skiing == 1 and prev_skiing == 0 and test_skiing == 0:
		prev_skiing = skiing
		test_skiing = 1
		_change_to_skiing()
	if skiing == 0 and prev_skiing == 1 and test_skiing == 0:
		prev_skiing = skiing
		test_skiing = 1
		_change_to_blue()
	if started_climbing != prev_climb:
		_climbthingy()
		prev_climb = started_climbing

	if finished_mic != prev_finished_mic:
		_micthingy()
		prev_finished_mic = finished_mic
	if first_run == 0 and start_sequence_done == 1:
		color = Color(0.195, 0.584, 0.93, 1.0)
		first_run = 1

func _micthingy() -> void:
	while color.r <= 0.8 or color.g >= 0.2 or color.b >= 0.2:
		change_r += 0.01
		change_g -= 0.01
		change_b -= 0.01
		await wait_time(0.07)
		_update_colors()
	flashing_red = 1

func _climbthingy() -> void:
	flashing_red = 0
	
	while color.r >= 0.2:
		change_r -= 0.03
		await wait_time(0.07)
		_update_colors()

	while color.g <= 0.584:
		change_g += 0.03
		await wait_time(0.07)
		_update_colors()

	while color.b <= 0.93:
		change_b += 0.03
		await wait_time(0.07)
		_update_colors()

func _change_to_skiing():
	while color.r <= 0.62 or color.g <= 0.8 or color.b <= 0.985:
		change_r += 0.02
		change_g += 0.01
		change_b += 0.005
		await wait_time(0.07)
		_update_colors()
	test_skiing = 0
	#color_blue = Color(0.618, 0.802, 0.991, 1.0)

func _change_to_blue():
	while color.r >= 0.2 or color.g >= 0.584 or color.b <= 0.93:
		change_r -= 0.02
		change_g -= 0.01
		change_b -= 0.005
		await wait_time(0.07)
	test_skiing = 0
	#color_blue = Color(0.195, 0.584, 0.93, 1.0)

func _update_colors() -> void:
	color = Color(change_r, change_g, change_b, 1.0)

func wait_time(seconds: float) -> void:
	var timer := Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
