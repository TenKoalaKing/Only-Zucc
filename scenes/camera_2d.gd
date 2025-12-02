extends Camera2D

@export var target_path: NodePath
@export var speed: float = 5.0
var target: Node2D
# Called when the node enters the scene tree for the first time.
func _ready():
	target=get_node(target_path)
	if target_path:
		target = get_node("Zuck Stage 1")
	if target:
		position = target.position
	else:
		print("Camera not tracking")



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if target:
		var _direction = target.position - position
		position = position.lerp(target.position, 1.0 - exp(-speed * delta)
		)
