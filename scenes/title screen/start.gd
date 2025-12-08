extends Control
@onready var button: Button = $start/Button

var play = 0

	
#func _ready() -> void:
	#button.pressed.connect(_on_button_pressed)

func _on_exit_to_menu():
	play = 0

func _on_button_pressed() -> void:
	print("button works")
	play = 1
