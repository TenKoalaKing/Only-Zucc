extends Area2D
@export var start_path:NodePath
@onready var start_script = get_node(start_path)
var start = 0
var changed = 0
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	start = start_script.play
	if start == 67:
		changed = 0
		print("Reseted from gym")


func _on_body_entered(body: Node2D) -> void:
	print("area_barb Body entered: ", body.name) 
	if (body.name == "zuck_stage_1") or body.is_in_group("player") or (body.name == "Zuck Stage 1"):
		print("entered zuck gym")
		changed = 1
