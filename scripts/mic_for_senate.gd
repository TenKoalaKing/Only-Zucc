extends Node2D
@export var start_path:NodePath
@onready var start_script = get_node(start_path)
@onready var dialog: Node = %Dialog
@onready var dia = $Dialog
@onready var dialog_indicator: TextureRect = %DialogIndicator
var dialog_inTalkRange
var mic_in_dialog = 0
var dialogNumber = 0
var done := 0
var deploy := 0
var start_c := 0
func _ready() -> void:	
	dialog_indicator.hide()
	process_mode = Node.PROCESS_MODE_ALWAYS
	start_c = 0
func _process(_delta: float) -> void:
	dialogNumber = dialog.dialogNumber
	print(dialogNumber)
	if dialogNumber == 1:
		deploy = 1
	if dialogNumber == 4:
		done = 1
		start_c = 1
func _on_talk_range_body_entered(body: Node2D) -> void:
	if body.name.contains("Zuck") or body.is_in_group("player"):
		dialog_indicator.show()
		mic_in_dialog = 1
		dialog.inTalkRange = true
			#print(dialogNumber)

func _on_talk_range_body_exited(body: Node2D) -> void:
	if body.name.contains("Zuck") or body.is_in_group("player"):
		dialog_indicator.hide()
		dialog.inTalkRange = false

func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
