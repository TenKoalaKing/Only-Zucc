extends CharacterBody2D

@export var start_path:NodePath
@onready var start_script = get_node(start_path)

@export var edward_path:NodePath
@onready var edward_script = get_node(edward_path)

#@export var health_bar_path:NodePath
#@onready var health_bar_script = get_node(health_bar_path)

const SPEED = 720.0
const JUMP_VELOCITY = -627.0 #used to be -550.0
var start_variable = 1
@onready var animated_sprite = $AnimatedSprite2D
var health = 3
var edward_health = 3
var punch = 0
var fight = 0
var theoretical_direction = 0
var edward_in_hitbox = 0
var facing = 0
var facing_range = 0

func _ready() -> void:
	add_to_group("player")
func _physics_process(delta: float) -> void:
	health = edward_script.zuck_health #health not updating
	#print(health)
	start_variable = start_script.play
	# Add the gravity.
	if start_variable != 0:
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
		fight = edward_script.fight
		if Input.is_action_just_pressed("punch") and fight == 1:
			punch = 1
			animated_sprite.play("fighting")
			if edward_in_hitbox == 1 and facing == facing_range:
				edward_health -= 1
				#play a successful hit sound***
				print ("edwardo hit")
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		#gets input direction -1,0,1
		var direction := Input.get_axis("move_left", "move_right")
		#flip sprite
		theoretical_direction = direction
		if punch == 1 and direction != 1:
			theoretical_direction = -1 * direction
			#print("switched for punch")
			#print(direction)
			#print("theoretical")
			#print(theoretical_direction)
		if theoretical_direction > 0:
			animated_sprite.flip_h = true
			facing = 1
		elif theoretical_direction <= 0:
			animated_sprite.flip_h = false
			facing = -1
		if punch == 1:
			await wait_time(.5)
			punch = 0
	
	#play animations
		if is_on_floor():
			#if punch == 1:
				#animated_sprite.play("fighting")
			if direction == 0:
				animated_sprite.play("default")
			else:
				animated_sprite.play("running")
		else:
			animated_sprite.play("jumping")
	
	
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()
	else:
		pass



func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()


func _on_hit_range_left_body_entered(body: Node2D) -> void:
	facing_range =  -1
	edward_in_hitbox = 1
func _on_hit_range_left_body_exited(body: Node2D) -> void:
	edward_in_hitbox = 0
func _on_hit_range_right_body_entered(body: Node2D) -> void:
	facing_range = 1
	edward_in_hitbox = 1
func _on_hit_range_right_body_exited(body: Node2D) -> void:
	edward_in_hitbox = 0
