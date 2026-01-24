extends Node2D

@export var start_path: NodePath
@onready var start_script = get_node(start_path)

@onready var dialog_node = %Dialog
@onready var dialog_indicator: TextureRect = %DialogIndicator
@onready var collision_shape: CollisionShape2D = $CollisionShape2D

var mic_in_dialog := false
var finished := false
var deploy := false
var start_c := false
var slime := 2


func _ready() -> void:
	dialog_indicator.hide()
	process_mode = Node.PROCESS_MODE_ALWAYS

	if dialog_node.has_signal("dialog_stepped"):
		dialog_node.dialog_stepped.connect(_on_dialog_stepped)
	else:
		push_error("Dialog node missing dialog_stepped signal")


# ================================
# DIALOG FLOW
# ================================
func _on_dialog_stepped(number: int) -> void:
	print("Dialog stepped:", number)
	deploy = true

	match number:
		1:
			collision_shape.disabled = true

		4:
			_finish_dialog()


func _finish_dialog() -> void:
	finished = true
	start_c = true
	mic_in_dialog = false

	dialog_node.inTalkRange = false
	dialog_indicator.hide()


# ================================
# TALK RANGE
# ================================
func _on_talk_range_body_entered(body: Node2D) -> void:
	if finished:
		return

	if body.is_in_group("player") or body.name.contains("Zuck"):
		mic_in_dialog = true
		dialog_node.inTalkRange = true
		dialog_indicator.show()


func _on_talk_range_body_exited(body: Node2D) -> void:
	if body.is_in_group("player") or body.name.contains("Zuck"):
		mic_in_dialog = false
		dialog_node.inTalkRange = false
		dialog_indicator.hide()


# ================================
# OPTIONAL UTILITY
# ================================
func wait_time(seconds: float) -> void:
	var timer := Timer.new()
	timer.one_shot = true
	timer.wait_time = seconds
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
