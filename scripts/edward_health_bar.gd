extends CanvasLayer #script to attach to camera 2d and fetch health status from player and have the variable for when dead
@onready var animated_sprite = $Control/AnimatedSprite2D
@onready var edward_script
var health = 3
var previous_health = 4
var fight := 0
var edward
#var edward_script

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func _ready() -> void:
	await get_tree().process_frame
	animated_sprite.play("3")
	var players = get_tree().get_nodes_in_group("edward")
	if players.size() > 0:
		edward_script = players[0]
		print("found_player")
		#edward = get_node(edward_script)
	else:
		print("player not found")
	self.visible = false
func _process(_delta: float) -> void:
	await get_tree().process_frame
	if is_instance_valid(edward_script):
		fight = edward_script.fight
		health = edward_script.health
	else:
		fight = 0
		health = 0

	if fight == 1:
		self.visible = true
	else:
		self.visible = false
	
	if health != previous_health:
		update_health_ui(health)
		previous_health = health
func update_health_ui(current_health: int) -> void:
	var anim_name = clamp(current_health, 0 ,3)
	match anim_name:
		0:
			animated_sprite.play("0")
		1:
			animated_sprite.play("1")
		2:
			animated_sprite.play("2")
		3:
			animated_sprite.play("3")




func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
