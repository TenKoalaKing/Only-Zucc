extends CanvasLayer #script to attach to camera 2d and fetch health status from player and have the variable for when dead
@onready var animated_sprite = $AnimatedSprite2D
var zuck_script: Node = null #not actually zuck script but potential workaround
#@onready var zuck_script = %"Zuck Stage 1"
var health := 3
var previous_health := 4
var fight := 0
var prev_fight := 0
var first_run := 0
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
	fight = zuck_script.fight #E 0:00:50:288   _ready: Invalid access to property or key 'fight' on a base object of type 'null instance'.
#  <GDScript Source>health_bar.gd:21 @ _ready()
#  <Stack Trace> health_bar.gd:21 @ _ready()
#                game_manager_fight.gd:30 @ _ready()
#                game_manager_fight.gd:53 @ wait_time()

	health = zuck_script.health
func _process(_delta: float) -> void:
	if first_run == 0:
		#zuck_script = get_tree().get_first_node_in_group("player")
		self.visible = false
		first_run = 1
	#health = zuck_script.health
	#fight = zuck_script.fight
	if fight == 1:
		self.visible = true
	elif fight == 0:
		self.visible = false
	#sake of testing
	#prev_fight = fight
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
