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
var battle_status = 0
var previous_bt = 0
var start = 0
var health = 0
var prev_fight = 0
func _ready() -> void:
	var canvas_layer = CanvasLayer.new()
	add_child(canvas_layer)
	var hud_instance = hud_scene.instantiate()
	hud_instance.zuck_script = self #not actually zuck script just for fillin purposes
	#add_child(hud_instance)
	#var hud_instance = hud_scene.instantiate()
	var canvas = get_node_or_null("health_bar")
	if canvas:
		canvas.add_child(hud_instance)
	else:
		add_child(hud_instance)
	
	while 1 == 1:
		await wait_time(.25)
		if is_instance_valid(edward_sulivan_script):
			fight = edward_sulivan_script.fight
		else:
			fight = 0
		battle_status = fight_area_script.in_fight_area
#		if battle_status == 1 and previous_bt == 0 and fight == 1:
#			#canvas_layer.add_child(hud_instance)
#			self.visible = true
#			previous_bt = 1
#		if battle_status == 0 and previous_bt == 1 and fight == 0:
#			#canvas_layer.remove_child(hud_instance)
#			self.visible = false
#			previous_bt = 0
		start = start_script.play
		if start == 67:
			fight = 0
			battle_status = 0
			previous_bt = 0
func _process(_delta: float) -> void:
	health = zuck_script.health
	fight = zuck_script.fight
	if fight == 0 and prev_fight == 0:
		self.visible = false
	elif fight == 1 and prev_fight == 0:
		self.visible = true
	if fight == 0 and prev_fight == 1:
		self.visible = false
	prev_fight = fight
func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()
