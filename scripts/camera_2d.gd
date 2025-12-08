extends Camera2D


@export var start_path:NodePath
@onready var start_script = get_node(start_path)
var start = 1
@export var target_path: NodePath
@export var speed: float = 5.0
var target: Node2D
var selected = 2 #0 is player, 1 is invisble node to shift camera prespective
var previous_selected = null
var target_menu_outro = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	# Wait a frame to ensure all nodes are ready
	await get_tree().process_frame
	#await wait_time(2)
	while 1 == 1:
		await wait_time(.25)
		if selected == previous_selected and start != 1:
			pass
		else:
			start = start_script.start
			if start == 1:
				selected = 2
			if start == 0:
				selected = 0
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
	
	if target:
		global_position = target.global_position
	else:
		print("Camera not tracking")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target:
		if selected == 2:
			global_position = target.global_position
			target_menu_outro = 1
		else:
			if target_menu_outro == 1:
				global_position = target.global_position
			global_position = global_position.lerp(target.global_position, 1.0 - exp(-speed * delta))
		
		
func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
