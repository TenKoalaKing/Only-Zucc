extends Camera2D

@export var target_path: NodePath
@export var speed: float = 5.0
var target: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	# Wait a frame to ensure all nodes are ready
	await get_tree().process_frame
	
	if target_path != NodePath(""):
		if has_node(target_path):
			target = get_node(target_path)
			print("Camera tracking: ", target.name)
		else:
			print("Node not found at path: ", target_path)
	else:
		# Try to find the node by name as fallback
		target = get_node_or_null("../Zuck Stage 1")
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
		global_position = global_position.lerp(target.global_position, 1.0 - exp(-speed * delta))
