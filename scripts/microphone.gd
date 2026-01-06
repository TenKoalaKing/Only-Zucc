extends CharacterBody2D
@onready var zuck = %"Zuck Stage 1"
@onready var edward_script = %"Edward Sulivan"
			#self.visible = false
			#$CollisionShape2D.disabled = true
var health = 3
var count = 0
var edward_health = 3
func _ready() -> void:
	self.visible = false
	$CollisionShape2D.disabled = true
	$asd.disabled = true
	$asd2.disabled = true
	$asd3.disabled = true
	$CollisionShape2D2.disabled = true
	while count == 0:
		await wait_time(.25)
		health = zuck.health
		edward_health = edward_script.health
		if health <= 0 or edward_health <= 0:
			self.visible = true
			$CollisionShape2D.disabled = false
			$asd.disabled = false
			$asd2.disabled = false
			$asd3.disabled = false
			$CollisionShape2D2.disabled = false
			count = 2 #can use count == 2 for cloud appearing.

func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
