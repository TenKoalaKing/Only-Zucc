extends Camera2D

@export var target_path: NodePath
@export var speed: float = 5.0
var target: Node2D
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	target=get_node(target_path)
	if target == null:
		print("camera target not found")
	if target_path:
		target = get_node("../Zuck Stage 1")
	if target:
		position = target.position



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target:
		var _direction = target.position - position
		position = position.lerp(target.position, 1.0 - exp(-speed * delta)
		)
