extends TileMap
@export var color_rect_path:NodePath
@onready var color_rect_script = get_node(color_rect_path)
var flashing_red := 0
var current_in_func := 0
var random_int := 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	flashing_red = color_rect_script.flashing_red
	if flashing_red == 1 and current_in_func == 0:
		current_in_func = 1
		_pre_flash()

func _pre_flash():
	random_int = randi_range(3, 10)
	await wait_time(random_int)
	flash_tilemap()
	current_in_func = 0

func flash_tilemap():
	var tween = create_tween()
	var mat = material
	mat.set_shader_parameter("flash_color", Color(1,0,0,1))
	tween.tween_property(mat, "shader_parameter/flash_modifier", 1.0, 0.1)
	tween.tween_property(mat, "shader_parameter/flash_modifier", 0.0, 0.1)


func wait_time(seconds: float) -> void:
	var timer = Timer.new()
	timer.wait_time = seconds
	timer.one_shot = true
	add_child(timer)
	timer.start()
	await timer.timeout
	timer.queue_free()

#shader_type canvas_item;

#uniform vec4 flash_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
#uniform float flash_modifier :
#hint_range(0.0, 1.0) = 0.0;

#void fragment(){
#	vec4 color = texture(TEXTURE, UV);
#	color.rgb - mix(color.rgb, flash_color.rgb, flash_modifier);
#	COLOR = color;
#}
