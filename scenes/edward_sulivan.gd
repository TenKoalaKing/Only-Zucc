extends CharacterBody2D

@onready var zuck = %"Zuck Stage 1"
@onready var animated_sprite = $AnimatedSprite2D
@onready var dialog: Node = %Dialog
@onready var dia = %Dialog
@onready var dialog_indicator: TextureRect = %DialogIndicator
#@export var zuck_path:NodePath
#@onready var zuck_script = get_node(zuck_path)
var dialog_inTalkRange
var dialogNumber = 0
var edward_in_dialog = 0
const SPEED = 3.7
const JUMP_VELOCITY = -400.0
var random = 0
var direction_random = 0
var direction = 0
var count = 0
var fight = 0
var finished_dialog = 0
var health = 3
var zuck_health = 3
var punch_random = 0
var punch = 0
var zuck_in_hitbox = 0
var edward_health = 3
var facing = 0
var facing_range = 0

#testing script that is in slime script:

#func _on_talk_range_body_entered(body: Node2D) -> void:
#	if body.name.contains("Zuck") or body.is_in_group("player"):
#		print("entered works")
#		dialog_indicator.show()
#		dialog.inTalkRange = true
#func _on_talk_range_body_exited(body: Node2D) -> void:
#	if body.name.contains("Zuck") or body.is_in_group("player"):
#		print("exited works")
#		dialog_indicator.hide()
#		dialog.inTalkRange = false
#		animated_sprite.play("default")


func _ready() -> void:	
	dialog_indicator.hide()
	while 1 == 1:
		await wait_time(.25)
		dialogNumber = dialog.dialogNumber
		finished_dialog = dialog.finished
		#if dialogNumber == 3: #number to equal dialog array number (now testing for fight variable instead
			#fight = 1
		if finished_dialog == 1:
			fight = 1
		if fight == 1:
			animated_sprite.play("fighting")
func _on_talk_range_body_entered(body: Node2D) -> void:
	if body.name.contains("Zuck") or body.is_in_group("player"):
		if fight == 0:
			dialog_indicator.show()
			edward_in_dialog = 1
			dialog.inTalkRange = true
			print("Player entered range")
			

#func _input(_event: InputEvent) -> void:
	#if Input.is_action_just_pressed("ui_accept"):
		#dialogNumber = dialogNumber + 1
		#print("dialog number")
		#print(dialogNumber)
# This runs once when the player leaves
func _on_talk_range_body_exited(body: Node2D) -> void:
	if body.name.contains("Zuck") or body.is_in_group("player"):
		dialog_indicator.hide()
		edward_in_dialog = 0
		dialog.inTalkRange = false
		print("Player left range")




func _physics_process(delta: float) -> void:
	# Add the gravity.
	fight = dialog.finished
	health = zuck.health
	if fight == 1:
		if punch == 1:
			animated_sprite.play("fighting")
			if zuck_in_hitbox == 1 and facing == facing_range:
				edward_health -= 1
				#play a successful hit sound***
				print ("zuck hit")
		if not is_on_floor():
			velocity += get_gravity() * delta

	# Handle jump.
		if is_on_floor() and random == 7:
			velocity.y = JUMP_VELOCITY
			random = 0
		if direction != 0:
			velocity.x = (direction / abs(direction)) * SPEED * 37#change for steady speed
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED*37)
		#flip sprite
		
		if direction < 0: #flipped compared to zuck stage 1
			animated_sprite.flip_h = true
			facing = -1 #test for opposites
		elif direction > 0:
			animated_sprite.flip_h = false
			facing = 1
		move_and_slide()
		if count == 0:
			count = 1 #prevents reruning frames
			_change_direction() #originally indented
	else:
		animated_sprite.play("default")

	
func _change_direction():
	random = randi() % 9 #random integer 1 - 10
	direction_random = randi() % 199 #
	if direction_random <= 99:
		direction = -1 * direction_random
	else:
		direction = direction_random - 100
	await wait_time(2)
	punch_random = randi() % 9
	if punch_random <= 2:
		punch = 0
	else:
		punch = 1
	await wait_time(1.5)
	count = 0
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
	zuck_in_hitbox = 1
func _on_hit_range_left_body_exited(body: Node2D) -> void:
	zuck_in_hitbox = 0
func _on_hit_range_right_body_entered(body: Node2D) -> void:
	facing_range = 1
	zuck_in_hitbox = 1
func _on_hit_range_right_body_exited(body: Node2D) -> void:
	zuck_in_hitbox = 0
