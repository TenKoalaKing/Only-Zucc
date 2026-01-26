extends ColorRect
@onready var ui_layer: CanvasLayer = get_node("/root/Game/CanvasLayer2")
var invis_color := 0.0
var flashing := false

func _ready() -> void:
	randomize()
	set_anchors_and_offsets_preset(Control.PRESET_FULL_RECT)
	color = Color(0.643, 0.179, 0.212, 0.0)
	visible = true


func flash():
	ui_layer.layer = 5
	if flashing:
		return

	flashing = true
	await _fade_in()
	await _fade_out()
	flashing = false


func _fade_in():
	while invis_color < 0.45:
		invis_color += 0.03
		color.a = invis_color
		await get_tree().create_timer(0.07).timeout


func _fade_out():
	while invis_color > 0.0:
		invis_color -= 0.07
		color.a = invis_color
		await get_tree().create_timer(0.07).timeout
