extends Node2D #script to attach to camera 2d and fetch health status from player and have the variable for when dead
@onready var animated_sprite = $AnimatedSprite2D
@onready var edward_script = %"Edward Sulivan"
var health = 3
var previous_health = 3
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
func _ready() -> void:
	animated_sprite.play("3")
	self.visible = false
func _process(_delta: float) -> void:
	health = edward_script.health
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
