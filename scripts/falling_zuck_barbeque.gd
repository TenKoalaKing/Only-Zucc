extends RigidBody2D
@export var start_path:NodePath
@onready var start_script = get_node(start_path)
@export var area_b_path:NodePath
@onready var area_b = get_node(area_b_path)
@onready var impact_audio = $AudioStreamPlayer
@export var nums:int
@export var bounce_strength: float = 0.8
var start_b = 0
var x_var = 0
var play_var = 0
var random_audio_pitch = 1
var first_run = 0
var start = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	freeze = true
	x_var = 5661 - (500 * nums)
	position = Vector2(x_var, -4306.0)
	var physics_material = PhysicsMaterial.new()
	physics_material.bounce = bounce_strength
	physics_material.friction = 0.5
	physics_material_override = physics_material
	play_var = 9 * (nums - 1)
	contact_monitor = true
	max_contacts_reported = 1
	rotation = randf_range(0, TAU) #tau is essentiall 2pi or 360degrees for future reference
	angular_velocity = randf_range(-10.0, 10.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	start = start_script.play
	start_b = area_b.start_b
	if start_b == 1 and first_run == 0:
		freeze = false
		first_run = 1
		_stop_physics_func()
	if start == 67:
		print("PANIC")
		start_b = 0
		x_var = 0
		play_var = 0
		random_audio_pitch = 1
		first_run = 0
		# Called when the node enters the scene tree for the first time.
		freeze = true
		x_var = 5661 - (500 * nums)
		position = Vector2(x_var, -4306.0)
		var physics_material = PhysicsMaterial.new()
		physics_material.bounce = bounce_strength
		physics_material.friction = 0.5
		physics_material_override = physics_material
		play_var = 9 * (nums - 1)
		contact_monitor = true
		max_contacts_reported = 1
		body_entered.connect(_on_body_entered)
		rotation = randf_range(0, TAU) #tau is essentiall 2pi or 360degrees for future reference
		angular_velocity = randf_range(-10.0, 10.0)
		start_b = area_b.start_b

func _stop_physics_func():
	await wait_time(4.67)
	while $AudioStreamPlayer.playing == true:
		$CollisionShape2D.disabled = false
	$CollisionShape2D.disabled = true
	

func _on_body_entered(_body: Node) -> void:
	if start_b == 1:
		#print("not working22")
		var velocity = linear_velocity.length()
		if velocity > 30:
			random_audio_pitch = randf_range(0.9, 1.1)
			impact_audio.pitch_scale = random_audio_pitch
			impact_audio.play(play_var)

func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
