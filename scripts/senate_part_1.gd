extends RigidBody2D

@export var start_path: NodePath
@onready var start_script = get_node(start_path)

@export var area_c_path: NodePath
@onready var area_c = get_node(area_c_path)

@export var nums: int
@export var bounce_strength: float = 0.8

var start_c := 0
var x_var := 0
var in_area := 0
var play_var := 0
var random_audio_pitch := 1.0
var first_run := 0
var start := 0
var starting_point: Vector2
var reset_position_active := false
var init := true



func _ready() -> void:

	sleeping = true

	match nums:
		1:
			x_var = 913
			starting_point = Vector2(x_var, -4622)
			$AnimatedSprite2D.play("1")
		2:
			x_var = 108
			starting_point = Vector2(x_var, -4622)
			$AnimatedSprite2D.play("2")
		3:
			x_var = 1278
			starting_point = Vector2(x_var, -4622)
			$AnimatedSprite2D.play("3")
		4:
			x_var = -3340
			starting_point = Vector2(x_var, -7939)
			$AnimatedSprite2D.play("4")
		5:
			x_var = -1440
			starting_point = Vector2(x_var, -7939)
			$AnimatedSprite2D.play("5")
		6:
			x_var = 688
			starting_point = Vector2(x_var, -7939)
			$AnimatedSprite2D.play("6")
		7:
			x_var = -293
			starting_point = Vector2(x_var, -10645)
			$AnimatedSprite2D.play("7")
		8:
			x_var = 1922
			starting_point = Vector2(x_var, -9159)
			$AnimatedSprite2D.play("8")
			$Area2D/CollisionShape2D.shape.radius *= 0.3
			$Area2D/CollisionShape2D.shape.height *= 0.3
			$AnimatedSprite2D.scale = Vector2(0.3, 0.3)
		9:
			x_var = -834
			starting_point = Vector2(x_var, -10645)
			$AnimatedSprite2D.play("9")

	position = starting_point



	print("READY — waiting for player")
	



func _process(_delta: float) -> void:
	start = start_script.play
	start_c = area_c.start_c
	if start_c == 0:
		position = starting_point
	elif start_c == 1 and init:
		var physics_material := PhysicsMaterial.new()
		physics_material.bounce = bounce_strength
		physics_material.friction = 0.3
		physics_material_override = physics_material
		
		contact_monitor = true
		max_contacts_reported = 1

		rotation = randf_range(0.0, TAU)
		angular_velocity = randf_range(-10.0, 10.0)
		sleeping = false
		init = false
	if not reset_position_active:
		_reset_position()



func _on_area_2d_body_entered(body: Node) -> void:
	print("BODY ENTERED:", body.name, " GROUPS:", body.get_groups())

	if body.is_in_group("player") and in_area == 0:
		_in_body()



func _in_body() -> void:
	in_area = 1
	print("PLAYER CONFIRMED IN AREA")
	await wait_time(0.5)
	in_area = 0



func _reset_position() -> void:
	reset_position_active = true
	await wait_time(2.0)
	position = starting_point
	#print(nums, " reset complete")
	reset_position_active = false



func wait_time(seconds: float) -> void:
	var timer := Timer.new()
	timer.one_shot = true
	timer.wait_time = seconds
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
