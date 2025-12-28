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
	while 1 == 1:
		await wait_time(.25)
		health = edward_script.health
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
