extends Node2D

@export var start_path: NodePath
@export var mic_path: NodePath
@export var randomStrength: float = 30.0
@export var shakeFade: float = 5.0

@onready var start_script = get_node(start_path)
@onready var mic_script = get_node(mic_path)

var rng := RandomNumberGenerator.new()
var shake_strength: float = 0.0

var talking := 0
var prev_talking := 0
var done := 0
var reset := 0

var original_position: Vector2

func _ready() -> void:
	rng.randomize()
	original_position = position

func _process(delta: float) -> void:
	talking = mic_script.dialogNumber

	if prev_talking != talking:
		apply_shake()
		prev_talking = talking

	if shake_strength > 0.0:
		shake_strength = lerp(shake_strength, 0.0, shakeFade * delta)
		position = original_position + random_offset()
	else:
		position = original_position

	done = mic_script.done
	if done == 1:
		visible = false

	reset = start_script.reset
	if reset == 1:
		visible = true

func apply_shake() -> void:
	shake_strength = randomStrength

func random_offset() -> Vector2:
	return Vector2(
		rng.randf_range(-shake_strength, shake_strength),
		rng.randf_range(-shake_strength, shake_strength)
	)
