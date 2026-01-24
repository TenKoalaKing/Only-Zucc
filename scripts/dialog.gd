extends Node

# Array of dialogue strings to display
@export_multiline var strings: Array[String] = []
signal dialog_stepped(number: int)
# UI references
@onready var canvas_layer: CanvasLayer = $CanvasLayer
@onready var label: Label = %Label
@onready var slime_script = get_parent()
#var slime = 0
#var camera_focus = 0

# Dialogue state variables
var inTalkRange := false  # Is player in range to talk?
var character_speaking: Tween  # Tween for text animation
var textLoaded = true  # Has current text finished loading?
var dialogNumber := 0
func step_dialog():
	dialogNumber += 1
	await get_tree().process_frame
	emit_signal("dialog_stepped", dialogNumber)
	print("Emitting", dialogNumber)

 #int = 0:
#	set(value):
#		dialogNumber = value
#		await get_tree().process_frame
#		dialog_stepped.emit(dialogNumber)
  # Current dialogue index
var finished = 0 # for parent functions

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	canvas_layer.hide()  # Hide dialogue UI at start
	#add_to_group("player")  # Add to player group
	#while 1 == 1:
		#await wait_time(.25)
		#slime = slime_script.slime_in_dialog

func _input(_event: InputEvent) -> void:
	# Check if dialogue is visible and handle appropriate input
	if canvas_layer.visible:
		_dialog_input()
	else:
		_talk_to_input()

func _dialog_input():
	# Handle input when dialogue is active
	if Input.is_action_just_pressed("ui_accept"):
		if textLoaded:
			_next_dialog()  # Go to next dialogue line
			step_dialog()
		else:
			_fast_show()  # Skip text animation

func _next_dialog():
	# Move to next dialogue or quit if at end
	dialogNumber += 1
	#print(dialogNumber)
	if dialogNumber >= strings.size():  # Fixed: Added >= for safety
		_quit_dialog()
		finished = 1
	else:
		_start_dialog()

func _quit_dialog():
	# Exit dialogue system
	dialogNumber = 0
	get_tree().paused = false
	canvas_layer.hide()

func _fast_show():
	# Skip text animation and show full text immediately
	if character_speaking:  # Fixed: Check if tween exists before killing
		character_speaking.kill()
	label.visible_ratio = 1.0  # Fixed: Use 1.0 for float
	textLoaded = true

func _talk_to_input():
	# Handle input when not in dialogue (start dialogue if in range)
	if Input.is_action_just_pressed("interation") and inTalkRange:
		_start_dialog()

func _start_dialog():
	# Initialize and start dialogue display
	if dialogNumber >= strings.size():  # Fixed: Safety check
		return
	canvas_layer.show()  # Show dialogue UI
	label.visible_ratio = 0.0  # Reset text visibility
	label.text = strings[dialogNumber]  # Set current dialogue text
	get_tree().paused = true  # Pause game
	_dialog_animation()  # Start text animation

func _dialog_animation():
	# Animate text appearing character by character
	textLoaded = false
	
	# Kill previous tween if it exists
	if character_speaking:
		character_speaking.kill()
	
	# Create new tween for text animation
	character_speaking = create_tween()
	character_speaking.tween_property(label, "visible_ratio", 1.0, 1.0)  # Fixed: correct method and property
	await character_speaking.finished
	textLoaded = true




func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
