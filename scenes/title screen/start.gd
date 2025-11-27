extends Control

@onready var button: Button = $Button

signal play_pressed


func _ready() -> void:
	button.pressed.connect(_on_button_pressed)


func _on_button_pressed() -> void:
	print("button works")
	play_pressed.emit()
	get_tree().change_scene_to_file("res://scenes/game.tscn")
