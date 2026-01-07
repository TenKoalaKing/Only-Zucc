extends Area2D
@onready var game_manager = %"Game Manager"
@export var start_path:NodePath
@onready var start_script = get_node(start_path)
var count = 0
var start = 0
func _on_body_entered(_body: Node2D) -> void:
	if count == 0:
		game_manager.add_point()
		self.visible = false
		count = 1
		$AudioStreamPlayer.play()
func _process(_delta: float) -> void:
	start = start_script.play
	if start == 67:
		count = 0
	$AnimatedSprite2D.play("default")
