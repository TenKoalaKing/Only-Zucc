extends Control

@onready var button: Button = $Button

signal settings_pressed


func _ready() -> void:
	button.pressed.connect(_on_button_pressed)


func _on_button_pressed() -> void:
	settings_pressed.emit()
