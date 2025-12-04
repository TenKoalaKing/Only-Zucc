extends Area2D

@onready var game_manager = %"Game Manager"
func _on_body_entered(_body: Node2D) -> void:
	game_manager.add_point()
	print()
	queue_free()
