extends Node2D
@onready var collision = $CollisionShape2D
@export var mic_main_path:NodePath
@onready var mic_main_script = get_node(mic_main_path)
var done = 0

func _ready() -> void:
	pass # Replace with function body.
func _process(_delta: float) -> void:
	done = mic_main_script.done
	if done == 1:
		self.visible = false
		collision.disabled = true
