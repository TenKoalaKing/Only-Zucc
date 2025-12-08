extends Node

# Array of dialogue strings to display
@export_multiline var strings: Array[String] = []

# UI references
@onready var canvas_layer: CanvasLayer = %CanvasLayer
@onready var label: Label = %Label

# Dialogue state variables
var inTalkRange := false  # Is player in range to talk?
var character_speaking: Tween  # Tween for text animation
var textLoaded = true  # Has current text finished loading?
var dialogNumber = 0  # Current dialogue index

func _ready() -> void:
	canvas_layer.hide()  # Hide dialogue UI at start
	add_to_group("player")  # Add to player group

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
		else:
			_fast_show()  # Skip text animation

func _next_dialog():
	# Move to next dialogue or quit if at end
	dialogNumber += 1
	if dialogNumber >= strings.size():  # Fixed: Added >= for safety
		_quit_dialog()
	else:
		_start_dialog()

func _quit_dialog():
	# Exit dialogue system
	get_tree().paused = false
	dialogNumber = 0
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
