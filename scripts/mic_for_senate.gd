extends Node2D
@onready var dialog_node = %Dialog
@onready var dialog_indicator: TextureRect = %DialogIndicator
@export var start_path:NodePath
@onready var start_script = get_node(start_path)
var dialog_inTalkRange
var mic_in_dialog = 0
var done := 0
var deploy := 0
var start_c := 0
var finished := 0
var slime := 0
func _ready() -> void:	
	#print(dialog_node)
	#print(dialog_node.get_path())
	#print(dialog_node.has_signal("dialog_stepped"))

	dialog_indicator.hide()
	process_mode = Node.PROCESS_MODE_ALWAYS
	start_c = 0
	dialog_node.dialog_stepped.connect(_on_dialog_stepped)
func _on_dialog_stepped(number: int) -> void:
	print("Dialog stepped", number)
	match number:
		1:
			deploy = 1
			$CollisionShape2D.disabled = true
			finished = 1
		4:
			done = 1
			start_c = 1
func _on_talk_range_body_entered(body: Node2D) -> void:
	if body.name.contains("Zuck") or body.is_in_group("player"):
		if finished == 0:
			dialog_indicator.show()
			mic_in_dialog = 1
			dialog_node.inTalkRange = true
				#print(dialogNumber)

func _on_talk_range_body_exited(body: Node2D) -> void:
	if body.name.contains("Zuck") or body.is_in_group("player"):
		if finished == 0:
			dialog_indicator.hide()
			dialog_node.inTalkRange = false


func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
