extends Control
var play = 0
@onready var button: Button = $Button #problem with button


func _ready() -> void:
	button.pressed.connect(_on_button_pressed)
	
func _on_exit_to_menu():
	play = 0

func _on_button_pressed() -> void:
	#print("button works")
	play = 1
func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
