extends Node2D
@export var fight_path:NodePath
@onready var fight_area_script = get_node(fight_path)
@export var zuck_path:NodePath
@onready var zuck_script = get_node(zuck_path)
@export var edward_sulivan_path:NodePath
@onready var edward_sulivan_script = get_node(edward_sulivan_path)
@export var start_path:NodePath
@onready var start_script = get_node(start_path)
var fight = 0
var hud_scene = preload("res://scenes/health_bar.tscn")
var hud_scene2 = preload("res://scenes/edward_health_bar.tscn")
var battle_status = 0
var previous_bt = 0
var start = 0
var health = 0
var prev_fight = 0
var hud_instance: Node = null
var hud_instance2: Node = null

func _ready() -> void:
	var canvas_layer = CanvasLayer.new()
	add_child(canvas_layer)
	hud_instance = hud_scene.instantiate()
	hud_instance2 = hud_scene2.instantiate()
	#hud_instance.zuck_script = self #not actually zuck script just for fillin purposes
	#add_child(hud_instance)
	#var hud_instance = hud_scene.instantiate()
	canvas_layer.add_child(hud_instance)
	canvas_layer.add_child(hud_instance2)

	# Hide them initially
	hud_instance.visible = false
	hud_instance2.visible = false

	# Start the async loop for checking fight status
	start_fight_loop()


func start_fight_loop() -> void:
	while true:
		await wait_time(0.25)

		# Check Edward's fight status
		if is_instance_valid(edward_sulivan_script):
			fight = edward_sulivan_script.fight
		else:
			fight = 0

		# Check if player is in the fight area
		battle_status = fight_area_script.in_fight_area

		# Reset conditions if the game has restarted
		start = start_script.play
		if start == 67:
			fight = 0
			battle_status = 0
			previous_bt = 0

		# Update HUD visibility
		if battle_status == 1 and fight == 1:
			hud_instance.visible = true
			hud_instance2.visible = true
		else:
			hud_instance.visible = false
			hud_instance2.visible = false


func _process(_delta: float) -> void:
	# Keep health and fight status updated
	if is_instance_valid(zuck_script):
		health = zuck_script.health
		fight = zuck_script.fight

	# Simple visibility toggle in case fight ends
	if fight == 0:
		hud_instance.visible = false
		hud_instance2.visible = false

	prev_fight = fight


func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
