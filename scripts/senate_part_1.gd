extends RigidBody2D #if death dosn't trigger in zuck, make script in process to create a var that stays changed for wait_time(.25)
@export var start_path:NodePath
@onready var start_script = get_node(start_path)
@export var area_c_path:NodePath
@onready var area_c = get_node(area_c_path)
@onready var impact_audio = $AudioStreamPlayer
@export var nums:int #numbers 1 - 9
@export var bounce_strength: float = 0.8
var start_c = 0
var x_var = 0
var in_area := 0
#play_var not used in anything just left in
var play_var = 0
var random_audio_pitch = 1
var first_run = 0
var start = 0
var velocity
var starting_point
var reset_position_active := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	freeze = true
	#x_var = 5661 - (500 * nums)
	#position = Vector2(x_var, -4306.0)
	match nums:
		1:
			x_var = 913
			starting_point = Vector2(x_var, -4622.0)
		2:
			x_var = 108
			starting_point = Vector2(x_var, -4622.0)
		3:
			x_var = 1278
			starting_point = Vector2(x_var, -4622.0)
		4:
			x_var = -3339.97
			starting_point = Vector2(x_var, -7939.0)
		5:
			x_var = -1440.0
			starting_point = Vector2(x_var, -7939.0)
		6:
			x_var = 688.0
			starting_point = Vector2(x_var, -7939.0)
		7:
			x_var = -293.0
			starting_point = Vector2(x_var, -10645.0)
		8:
			x_var = 1922
			starting_point = Vector2(x_var, -9159.0)
		9:
			x_var = -834.0
			starting_point = Vector2(x_var, -10645.0)
	position = starting_point
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
#1 and 4 should be able to have lazer function through additional area2D
func _process(_delta: float) -> void:
	start = start_script.play
	start_c = area_c.start_c
	if start_c == 1 and first_run == 0:
		freeze = false
		first_run = 1
	if start == 67:
		print("PANIC")
		start_c = 0
		x_var = 0
		play_var = 0
		random_audio_pitch = 1
		first_run = 0
		# Called when the node enters the scene tree for the first time.
		freeze = true
		#x_var = 5661 - (500 * nums)
		#position = Vector2(x_var, -4306.0)
		match nums:
			1:
				x_var = 913
				position = Vector2(x_var, -4622.0)
			2:
				x_var = 108
				position = Vector2(x_var, -4622.0)
			3:
				x_var = 1278
				position = Vector2(x_var, -4622.0)
			4:
				x_var = -3339.97
				position = Vector2(x_var, -7939.0)
			5:
				x_var = -1440.0
				position = Vector2(x_var, -7939.0)
			6:
				x_var = 688.0
				position = Vector2(x_var, -7939.0)
			7:
				x_var = -293.0
				position = Vector2(x_var, -10645.0)
			8:
				x_var = 1922
				position = Vector2(x_var, -9159.0)
			9:
				x_var = -834.0
				position = Vector2(x_var, -10645.0)
		var physics_material = PhysicsMaterial.new()
		physics_material.bounce = bounce_strength
		physics_material.friction = 0.5
		physics_material_override = physics_material
		play_var = 9 * (nums - 1)
		contact_monitor = true
		max_contacts_reported = 1
		rotation = randf_range(0, TAU) #tau is essentiall 2pi or 360degrees for future reference
		angular_velocity = randf_range(-10.0, 10.0)
		start_c = area_c.start_c
		if reset_position_active == 0 and start_c == 1:
			_reset_position()


func _reset_position():
	reset_position_active = 1
	await wait_time(4)
	position = starting_point
	reset_position_active = 0


func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	# DEBUG PRINT: This proves the signal is working
	print("Body entered: ", body.name) 
	
	if (body.name == "zuck_stage_1") or body.is_in_group("player") or (body.name == "Zuck Stage 1"):
		in_area = 1
	else:
		# DEBUG PRINT: This proves the logic failed
		print("Body entered but logic failed. Groups: ", body.get_groups())

func _on_area_2d_body_exited(body: Node2D) -> void:
	if (body.name == "zuck_stage_1") or body.is_in_group("player") or (body.name == "Zuck Stage 1"):
		in_area = 0
