extends Node2D #script to attach to camera 2d and fetch health status from player and have the variable for when dead
@onready var animated_sprite = $AnimatedSprite2D
@onready var zuck_script = %"Zuck Stage 1"
#@onready var zuck_script = %"Zuck Stage 1"
var health = 3
var previous_health = 3
var fight = 0
var prev_fight = 0
var first_run = 0
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass

func _ready() -> void:
	animated_sprite.play("3")
	#var zuck_script = get_tree().get_first_node_in_group("player")
	if zuck_script:
		print("found zucccy")
	else:
		print("zuck is not found in canvas layer")
	fight = zuck_script.fight
	health = zuck_script.health
func _process(_delta: float) -> void:
	if first_run == 0:
		#zuck_script = get_tree().get_first_node_in_group("player")
		first_run = 1
	#health = zuck_script.health
	#print(health)
	#fight = zuck_script.fight
	if fight == 0 and prev_fight == 0:
		self.visible = false
	prev_fight = fight
	if health != previous_health:
		if health == 3:
			previous_health = 3
			animated_sprite.play("3")
		if health == 2:
			previous_health	 = 2
			animated_sprite.play("2")
		if health == 1:
			previous_health = 1
			animated_sprite.play("1")
		if health == 0:
			previous_health = 0 #for replay
			animated_sprite.play ("0")




func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
