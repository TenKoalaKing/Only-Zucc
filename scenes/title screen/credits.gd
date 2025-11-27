extends Control

@onready var button: Button = $Button

signal credits_pressed


func _ready() -> void:
	button.pressed.connect(_on_button_pressed)


func _on_button_pressed() -> void:
	credits_pressed.emit()
