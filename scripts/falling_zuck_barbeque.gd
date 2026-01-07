extends RigidBody2D
@export var start_path:NodePath
@onready var start_script = get_node(start_path)
@export var area_b_path:NodePath
@onready var area_b = get_node(area_b_path)
@export var nums:int
@export var bounce_strength: float = 0.8

var x_var = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	x_var = 5561 - (500 * nums)
	position = Vector2()
	var physics_material = PhysicsMaterial.new()
	physics_material.bounce = bounce_strength
	physics_material.friction = 0.5
	physics_material_override = physics_material
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
