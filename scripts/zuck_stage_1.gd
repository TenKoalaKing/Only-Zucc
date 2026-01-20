extends CharacterBody2D

@export var start_path:NodePath
@onready var start_script = get_node(start_path)

@export var edward_path:NodePath
@onready var edward_script = get_node(edward_path)

@export var main_camera:NodePath
@onready var camera1 = get_node(main_camera)

@export var cloud_area_initial_path:NodePath
@onready var cloud_area_initial = get_node(cloud_area_initial_path)

@export var gym_path:NodePath
@onready var gym_script = get_node(gym_path)

@export var onep:NodePath
@onready var one = get_node(onep)
@export var twop:NodePath
@onready var two = get_node(twop)
@export var threep:NodePath
@onready var three = get_node(threep)
@export var fourp:NodePath
@onready var four = get_node(fourp)
@export var fivep:NodePath
@onready var five = get_node(fivep)
@export var sixp:NodePath
@onready var six = get_node(sixp)
@export var sevenp:NodePath
@onready var seven = get_node(sevenp)
@export var eightp:NodePath
@onready var eight = get_node(eightp)
@export var ninep:NodePath
@onready var nine = get_node(ninep)
#@export var health_bar_path:NodePath
#@onready var health_bar_script = get_node(health_bar_path)

const SPEED = 720.0
const JUMP_VELOCITY = -767.0 #used to be -550.0 676767
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
var moving = 0
var first_init = 0
var reset = 0
var start_sequence_done = 0
var prev_fight_var = 0
var cloud_area_initial_in_area = 0
var zuck_win = 0
var changed = 0
var camera_start_sequence = 0
var no_repeats = 0
func _ready() -> void:
	add_to_group("player")
	$AnimatedSprite2D.texture_filter = CanvasItem.TEXTURE_FILTER_NEAREST
func _process(_delta: float) -> void:
	_in_contact_with_senate()
	camera_start_sequence = camera1.start_sequence_start
	if camera_start_sequence == 1 and no_repeats == 0:
		no_repeats = 1
	if camera_start_sequence == 0:
		no_repeats = 0
		$begin_music.play()
	if animated_sprite.animation == "jumping2" or animated_sprite.animation == "default2":
		if animated_sprite.animation == "running2":
			animated_sprite.scale = Vector2(0.5, 0.5)
		else:
			animated_sprite.scale = Vector2(0.3, 0.3)
	else:
		animated_sprite.scale = Vector2(1,1)
func _physics_process(delta: float) -> void:
	changed = gym_script.changed
	if is_instance_valid(edward_script):
		health = edward_script.zuck_health #health not updating
	else:
		health = 3
	#print(health)
	if fight == 1:
		if health <= 0:
			$boo.play()
			await wait_time(.05)
			fight = 0
		if edward_health <= 0:
			$yay.play()
			await wait_time(.05)
			fight = 0
			zuck_win = 1
	start_variable = start_script.play
	start_sequence_done = camera1.start_sequence_done
	reset = (start_variable/67)
	if reset == 1:
		_reset()
	if start_variable == 1 and first_init == 0 and start_sequence_done == 1:
		$backround_music.play()
		first_init = 1 #end of init
	# Add the gravity.
	if start_variable != 0:
		if not is_on_floor():
			velocity += get_gravity() * delta
		if is_instance_valid(edward_script):
			fight = edward_script.fight
		else:
			fight = 0
		if fight == 1 and prev_fight_var == 0:
			$backround_music.stop()
			$fight_music.play()
			prev_fight_var = 1
		if fight == 0 and prev_fight_var == 1:
			$fight_music.stop()
			$backround_music.play(30)
			prev_fight_var = 0.5
		else:
			if Input.is_action_just_pressed("jump") and is_on_floor():
				velocity.y = JUMP_VELOCITY
		if prev_fight_var == 0.5:
			cloud_area_initial_in_area = cloud_area_initial.in_area
			if cloud_area_initial_in_area == 1:
				$backround_music.stop()
			prev_fight_var = 0
		if Input.is_action_just_pressed("punch") and fight == 1:
			punch = 1
			if animated_sprite.animation != "running":
				animated_sprite.play("fighting")
			if edward_in_hitbox == 1 and facing == facing_range:
				edward_health -= 1
				$ding.play()
				print ("edwardo hit")
			await get_tree().create_timer(0.5).timeout
			punch = 0
		#put fight cond in here
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
		if changed == 1:
			if is_on_floor():
			#if punch == 1:
				#animated_sprite.play("fighting")
				if direction == 0:
					if animated_sprite.animation != "default2":
						animated_sprite.play("default2")
					moving = 0
				else:
					if animated_sprite.animation != "running2":
						animated_sprite.play("running2")
					moving = 1
			else:
				if animated_sprite.animation != "jumping2":
					animated_sprite.play("jumping2")
				moving = 0
		if changed != 1:
			if is_on_floor():
				#if punch == 1:
					#animated_sprite.play("fighting")
				if direction == 0:
					if animated_sprite.animation != "default":
						animated_sprite.play("default")
					moving = 0
				else:
					if animated_sprite.animation != "running":
						animated_sprite.play("running")
					moving = 1
			else:
				if animated_sprite.animation != "jumping":
					animated_sprite.play("jumping")
				moving = 0
		
	
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		move_and_slide()
	else:
		pass
func _reset():
	position = Vector2(-1263, 916)
	start_variable = 1
	health = 3
	edward_health = 3
	punch = 0
	fight = 0
	theoretical_direction = 0
	edward_in_hitbox = 0
	facing = 0
	facing_range = 0
	moving = 0
	first_init = 0
	reset = 0
	start_sequence_done = 0
	prev_fight_var = 0
	cloud_area_initial_in_area = 0

#eventually get rid of wait_time in main script
func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()

#used _body to avoid errors: used to be "body"
func _on_hit_range_left_body_entered(_body: Node2D) -> void:
	facing_range =  -1
	edward_in_hitbox = 1
func _on_hit_range_left_body_exited(_body: Node2D) -> void:
	edward_in_hitbox = 0
func _on_hit_range_right_body_entered(_body: Node2D) -> void:
	facing_range = 1
	edward_in_hitbox = 1
func _on_hit_range_right_body_exited(_body: Node2D) -> void:
	edward_in_hitbox = 0

func _in_contact_with_senate():
	if one.in_area == 1 or two.in_area == 1 or three.in_area == 1 or four.in_area == 1 or five.in_area == 1 or six.in_area == 1 or seven.in_area == 1 or eight.in_area == 1 or nine.in_area == 1:
		#death so go back to respawn point will figure out later!
		print("will fufil")
