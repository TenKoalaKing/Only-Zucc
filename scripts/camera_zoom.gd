extends Camera2D
@export var start_path:NodePath
@onready var start_script = get_node(start_path)

# Define zoom levels as Vector2 (x and y zoom values)
# Higher values = more zoomed in, lower values = more zoomed out
var default_zoom = Vector2(1, 1)      # Normal zoom level (100%)
var zoomed_in = Vector2(0.5, 0.5)     # Zoomed in level (200% magnification)
var zoom_speed = 0.1                   # Speed of smooth zoom transition (0.0 to 1.0)
var zoom_out = 0
var zoom_in = 0
var start = 0
func _ready():
	await get_tree().process_frame
	print("hello")
	while 2 > 1:
		print("HEELLLOOO")
		await get_tree().process_frame
		start = start_script.play
		print(start)
		if start == 1: #and zoom_out == 1 or zoom_in == 1:
			# Toggle between default and zoomed in states
			print("works")
			if zoom == default_zoom:
				# If currently at default zoom, switch to zoomed in
				zoom = zoomed_in
			else:
				# If currently zoomed in, switch back to default
				zoom = default_zoom

# Will add movement for achievements...
# Process function runs every frame
func _process(_delta):
	# Check if zoom_in action is being held down
	if Input.is_action_pressed("zoom_in"):
		# Smoothly interpolate (lerp) current zoom towards zoomed_in state
		zoom = zoom.lerp(zoomed_in, zoom_speed)
	
	# Check if zoomed_in action is being held down
	# Note: This should probably be "zoom_out" instead of "zoomed_in"
	elif Input.is_action_pressed("zoomed_in"):
		# Smoothly interpolate current zoom back to default state
		zoom = zoom.lerp(default_zoom, zoom_speed)

func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
