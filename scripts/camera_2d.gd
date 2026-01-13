extends Camera2D

@export var start_path: NodePath
@export var dialog_node: Node
@export var speed: float = 5.0

@onready var start_script = get_node(start_path)
@onready var slime_node = %"Slime at start of game"

@export var slime_path:NodePath
@onready var slime_script = get_node(slime_path)

var start: int = 2
var target: Node2D
var selected: int = 2
var previous_selected: int = -1
var target_menu_outro := 1
var first_start := 1
var camera_focus_dialog := 0
var slime_camera_focus := 0
var start_sequence_done := 0
var reset := 0
var intro_running := false
var default_zoom = Vector2(.5, .5)      # Normal zoom level (100%)
var zoomed_in = Vector2(0.25, 0.25)     # Zoomed in level (50% magnification)
var zoom_speed = 0.1                   # Speed of smooth zoom transition (0.0 to 1.0)
var zoom_out = 0
var zoom_in = 0
var dialog_zoom = 0
var sharp_camera := true
var slime_focus = 0

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
		intro_running = false
		sharp_camera = true   # snap again if restarting

	if start == 1 and first_start == 1 and not intro_running:
		intro_running = true
		first_start = 0
		run_intro_sequence()
		return

	if start == 1 and previous_selected == 2:
		selected = 3
	elif start == 0:
		selected = 2
	if slime_focus == 2:
		selected = 8
	if slime_focus == 3:
		selected = 7
	if selected != previous_selected:
		update_target()

	# --- CAMERA MOVEMENT ---
	if target:
		if sharp_camera:
			# 🔹 NO SMOOTHING — instant snap
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
 #and zoom_out == 1 or zoom_in == 1:
		# Toggle between default and zoomed in states
	if slime_focus == 2:
		dialog_zoom = 1
	if slime_focus != 1:
		dialog_zoom = 0
	if dialog_zoom == 0:
		zoom = default_zoom
		# If currently at default zoom, switch to zoomed in
	if dialog_zoom == 1:
		zoom = zoomed_in
			# If currently zoomed in, switch back to default
#extra code made for manual control of zoom
	#if Input.is_action_pressed("zoom_in"):
		# Smoothly interpolate (lerp) current zoom towards zoomed_in state
	#	zoom = zoom.lerp(zoomed_in, zoom_speed)
	
	# Check if zoomed_in action is being held down
	# Note: This should probably be "zoom_out" instead of "zoomed_in"
	#elif Input.is_action_pressed("zoomed_in"):
		# Smoothly interpolate current zoom back to default state
	#	zoom = zoom.lerp(default_zoom, zoom_speed)




func run_intro_sequence() -> void:
	await move_camera("../invisible_tracker_1", 3)
	await move_camera("../invisible_tracker_2", 3)
	await move_camera("../static zuckerberg", 3)
	await move_camera("../BackOfClassroom", 3)
	await move_camera("../Facebook_com", 3)
	await move_camera("../BackOfClassroom", 3)

	start_sequence_done = 1
	previous_selected = 2
	intro_running = false

	# 🔹 Enable smoothing AFTER intro
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
	if target:
		print("Camera tracking:", target.name)
	else:
		print("Camera target missing")

func wait_time(seconds: float) -> void:
	var timer := Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
