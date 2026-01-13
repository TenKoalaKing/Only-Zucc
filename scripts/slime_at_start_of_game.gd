extends CharacterBody2D

@onready var dialog: Node = %Dialog
@onready var dia = $Dialog
@onready var dialog_indicator: TextureRect = %DialogIndicator

var dialog_inTalkRange
var slime_in_dialog = 0
var dialogNumber = 0
var camera_focus = 0
func _ready() -> void:	
	dialog_indicator.hide()
	process_mode = Node.PROCESS_MODE_ALWAYS
func _process(_delta: float) -> void:
	dialogNumber = dia.dialogNumber
	#print("heartbeat")    fix later if time for camera shifts during dialog
	print(dialogNumber)
	#print(camera_focus)
	if dialogNumber == 2:
		camera_focus = 1
	if dialogNumber == 3:
		camera_focus = 2
	if dialogNumber == 0:
		camera_focus = 0
func _on_talk_range_body_entered(body: Node2D) -> void:
	if body.name.contains("Zuck") or body.is_in_group("player"):
		dialog_indicator.show()
		slime_in_dialog = 1
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
