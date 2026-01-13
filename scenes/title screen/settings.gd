extends Control

@onready var button: Button = $Button
var settings = 0
signal settings_pressed


func _ready() -> void:
	button.pressed.connect(_on_button_pressed)


func _on_button_pressed() -> void:
	settings_pressed.emit()
	settings = 1
	await wait_time(.3)
	settings = 0

func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
