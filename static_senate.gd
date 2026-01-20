extends RigidBody2D
@export var mic_for_senate_path:NodePath
@onready var mic_for_senate = get_node(mic_for_senate_path)
var deploy := 0
var done := 0
@export var bounce_strength: float = 0.8
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	freeze = true
	self.visible = false
	var physics_material = PhysicsMaterial.new()
	physics_material.bounce = bounce_strength
	physics_material.friction = 0.5
	physics_material_override = physics_material
	contact_monitor = true
	max_contacts_reported = 1
	rotation = randf_range(0, TAU) #tau is essentiall 2pi or 360degrees for future reference
	angular_velocity = randf_range(-10.0, 10.0)
	$CollisionShape2D.disabled = false
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	deploy = mic_for_senate.deploy
	done = mic_for_senate.done
	if deploy == 1:
		self.visible = true
		freeze = false
	if done == 1:
		$CollisionShape2D.disabled = true
