extends Camera2D


@export var start_path:NodePath
@onready var start_script = get_node(start_path)
@onready var slime_node = %"Slime at start of game"
@export var dialog_node: Node
var start = 2
#@export var target_path: NodePath
@export var speed: float = 5.0
var target: Node2D
var selected = 2 #0 is player, 1 is invisble node to shift camera prespective (2 is menu)
var previous_selected = null
var target_menu_outro = 1
var first_start = 1
var camera_focus_dialog = 0
var slime_camera_focus = 0
var start_sequence_done = 0

func _ready():
	# Wait a frame to ensure all nodes are ready
	await get_tree().process_frame

func _process(delta):
	# --- INPUT UPDATE (Formerly in the while loop) ---
	#camera_focus_dialog = dialog_node.camera_focus
	start = start_script.play
	slime_camera_focus = slime_node.camera_focus
	
	# --- LOGIC SELECTION ---
	if 1 == 2:
		print("logic has betrayed me")
	else:
		if camera_focus_dialog == 2:
			target = get_node_or_null("../invisible_tracker_coin")
		
		if start == 1 and first_start == 1:
			# Without wait_time, these will all run instantly in one frame
			# resulting in the target ending up as the very last one immediately.
			target = get_node_or_null("../invisible_tracker_1")
			#ADD sound here bell
			#add backround noise for 11.5 seconds until end of script
			#FIX: start button doesn't work when clicked
			#await wait_time(1.5)
			target = get_node_or_null("../invisible_tracker_2")
			#await wait_time(1.5)
			target = get_node_or_null("../static zuckerberg")
			#await wait_time(1.5)
			target = get_node_or_null("../BackOfClassroom")
			#await wait_time(1.5)
			target = get_node_or_null("../Facebook_com")
			#await wait_time(1.5)
			target = get_node_or_null("../BackOfClassroom")
			#await wait_time(1.5)
			start_sequence_done = 1
			previous_selected = 2
			first_start = 0
		if start == 1 and previous_selected == 2:
			selected = 3
		if start == 0:
			selected = 2
		if slime_camera_focus == 1:
			selected = 7
			
		if selected == previous_selected:
			pass
		else:
			if selected == 0:
				target = get_node_or_null("../Zuck Stage 1")
				previous_selected = 0
				if target:
					print("Camera tracking (fallback): ", target.name)
				else:
					print("Camera not tracking - target_path not set")
			elif selected == 1:
				previous_selected = 1
				target = get_node_or_null("../invisible_tracker")
				if target:
					print("Camera tracking (fallback): ", target.name)
				else:
					print("Camera not tracking - target_path not set")
			elif selected == 2:
				previous_selected = 2
				target = get_node_or_null("../invisible_tracker_menu")
				if target:
					print("Camera tracking (fallback): ", target.name)
				else:
					print("Camera not tracking - target_path not set")
			elif selected == 3: #runs through camera tracking first before setteling on character in selected equaling 0
				target = get_node_or_null("../Zuck Stage 1")
				if target:
					print("Camera tracking (fallback): ", target.name)
				else:
					print("Camera not tracking - target_path not set")
				#await wait_time(3.5) REMOVED
				previous_selected = 3
			elif selected == 7:
				target = get_node_or_null("../invisible_tracker_door")
				if target:
					print("Camera tracking (fallback): ", target.name)
				else:
					print("Camera not tracking - target_path not set")

	# --- MOVEMENT APPLICATION ---
	if target:
		if selected == 2:
			global_position = target.global_position
			target_menu_outro = 1
		else:
			if target_menu_outro == 1:
				global_position = target.global_position
			# Smooth movement
			global_position = global_position.lerp(target.global_position, 1.0 - exp(-speed * delta))
	else:
		# Only print if this was the first frame and no target was found to avoid console spam
		pass
		
		
func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
