extends CharacterBody2D

@onready var zuck = %"Zuck Stage 1"
@onready var animated_sprite = $AnimatedSprite2D
@onready var dialog: Node = %Dialog
@onready var dia = %Dialog
@onready var dialog_indicator: TextureRect = %DialogIndicator
var dialog_inTalkRange

	
func _on_talk_range_body_entered(body: Node2D) -> void:
	if body.name.contains("Zuck") or body.is_in_group("player"):
		dialog_indicator.show()
		dialog.inTalkRange = true
func _on_talk_range_body_exited(body: Node2D) -> void:
	if body.name.contains("Zuck") or body.is_in_group("player"):
		dialog_indicator.hide()
		dialog.inTalkRange = false
		animated_sprite.play("default")

const SPEED = 3.7
const JUMP_VELOCITY = -400.0
var random = 0
var direction_random = 0
var direction = 0
var count = 0
var fight = 0

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if fight == 1:
		if not is_on_floor():
			velocity += get_gravity() * delta

	# Handle jump.
		if is_on_floor() and random == 7:
			velocity.y = JUMP_VELOCITY
		if direction:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		#flip sprite
		if direction < 0: #flipped compared to zuck stage 1
			animated_sprite.flip_h = true
		elif direction > 0:
			animated_sprite.flip_h = false
		move_and_slide()
	else:
		animated_sprite.play("default")

func _ready() -> void:
	dialog_indicator.hide()
	
	while count == 0 and fight == 1:
		await wait_time(1.1)
		random = randi() % 9 #
		direction_random = randi() % 199 #
		if direction_random <= 99:
			direction = -1 * direction_random
		else:
			direction = direction_random - 100
func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
