extends Node2D #script to attach to camera 2d and fetch health status from player and have the variable for when dead
@onready var animated_sprite = $AnimatedSprite2D
#@onready var edward_script = %"Edward Sulivan"
var health = 3
var previous_health = 4
var fight := 0
var edward_script

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func _ready() -> void:
	animated_sprite.play("3")
	var players = get_tree().get_nodes_in_group("edward")
	if players.size() > 0:
		edward_script = players[0]
		print("found_player")
	else:
		print("player not found")
	self.visible = false
func _process(_delta: float) -> void:
	fight = edward_script.fight
	health = edward_script.health
	if fight == 1:
		self.visible = true
	else:
		self.visible = false
	
	if health != previous_health:
		update_health_ui(health)
		previous_health = health
func update_health_ui(current_health: int) -> void:
	var anim_name = str(clamp(current_health, 0 ,3))
	$AnimatedSprite2D.play(anim_name)




func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
