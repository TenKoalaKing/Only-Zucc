extends Camera2D

@export var start_path: NodePath
@export var dialog_node: Node
@export var speed: float = 5.0
@export var slime_path: NodePath

@onready var start_script = get_node(start_path)
@onready var slime_script = get_node(slime_path)

var start := 2
var reset := 0

var target: Node2D
var selected := 2
var previous_selected := -1

var first_start := 1
var intro_running := false
var start_sequence_done := 0
var sharp_camera := true
var target_menu_outro := 1

var slime_focus := 0
var previous_slime_focus := -1

var default_zoom := Vector2(0.5, 0.5)
var zoomed_in := Vector2(0.8, 0.8)
var dialog_zoom := false
var previous_dialog_number := 0
var rand_selected = 0
var contingency = 0
var start_sequence_start = 0
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	await get_tree().process_frame

func _process(delta: float) -> void:
	start = start_script.play
	reset = start_script.reset
	slime_focus = slime_script.camera_focus

	if reset == 1:
		first_start = 1
		start_sequence_done = 0
		start_sequence_start = 0
		intro_running = false
		sharp_camera = true

	if start == 1 and first_start == 1 and not intro_running:
		intro_running = true
		first_start = 0
		run_intro_sequence()
		return
	rand_selected = selected
	if slime_script.dialogNumber != previous_dialog_number:
		previous_dialog_number = slime_script.dialogNumber
		if slime_script.dialogNumber != 0:
			match slime_script.dialogNumber:
				3:
					selected = 8
				4:
					selected = 7
				0:
					selected = rand_selected
		else:
			selected = rand_selected

	if selected == 7 and contingency == 0:
		_contingency()
		contingency = 1
	if not intro_running and slime_focus == 0:
		if start == 1 and previous_selected == 2:
			selected = 3
		elif start == 0:
			selected = 2

	if selected != previous_selected:
		update_target()

	if target:
		if sharp_camera:
			global_position = target.global_position
		else:
			if selected == 2:
				global_position = target.global_position
				target_menu_outro = 1
			else:
				if target_menu_outro == 1:
					global_position = target.global_position
					target_menu_outro = 0
				global_position = global_position.lerp(
					target.global_position,
					1.0 - exp(-speed * delta)
				)

	dialog_zoom = slime_focus == 2
	zoom = zoomed_in if dialog_zoom else default_zoom

func run_intro_sequence() -> void:
	start_sequence_start = 1
	#should last 13.84 seconds
	await move_camera("../invisible_tracker_1", 2.33333333333)
	await move_camera("../invisible_tracker_2", 2.33333333333)
	await move_camera("../static zuckerberg", 2.33333333333)
	await move_camera("../BackOfClassroom", 2.33333333333)
	await move_camera("../Facebook_com", 2.33333333333)
	await move_camera("../BackOfClassroom", 2.34)
	start_sequence_done = 1
	previous_selected = 2
	intro_running = false
	sharp_camera = false

func move_camera(path: String, delay: float) -> void:
	target = get_node_or_null(path)
	await wait_time(delay)

func update_target() -> void:
	previous_selected = selected
	match selected:
		0:
			target = get_node_or_null("../Zuck Stage 1")
		1:
			target = get_node_or_null("../invisible_tracker")
		2:
			target = get_node_or_null("../invisible_tracker_menu")
		3:
			target = get_node_or_null("../Zuck Stage 1")
		7:
			target = get_node_or_null("../invisible_tracker_door")
		8:
			target = get_node_or_null("../invisible_tracker_coin")
func _contingency():
	await wait_time(6.3)
	target = get_node_or_null("../Zuck Stage 1")
	selected = 3
	await wait_time(.1)
	selected = 3
	contingency = 0
func wait_time(seconds: float) -> void:
	var timer := Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
