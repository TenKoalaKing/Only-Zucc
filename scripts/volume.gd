extends Control

@export var settings_path:NodePath
@onready var settings_script = get_node(settings_path)

@onready var s: HSlider = $HSlider
var master := AudioServer.get_bus_index("Master")
var settings = 0

func _ready() -> void:
	#var style = $HSlider.get_stylebox("fg")
	#$HSlider.add_stylebox_override("fg", StyleBoxFlat.new())
	#style.set_content_margin(StyleBox.MARGIN_TOP, 4)
	#style.set_content_margin(StyleBox.MARGIN_BOTTOM, 4)
	#$HSlider.get_stylebox("fg").set_content_margin(MARGIN_TOP, 4)
	#$HSlider.get_stylebox("fg").set_content_margin(MARGIN_BOTTOM, 4)
	# Set slider range from 0 to 100
	s.value = 100
	s.min_value = 0
	s.max_value = 100
	self.visible = false
	# Connect the value_changed signal
	s.connect("value_changed", Callable(self, "_on_slider_value_changed"))
	# Initialize volume
	_on_slider_value_changed(s.value)

func _process(_delta: float) -> void:
	settings = settings_script.settings
	if settings == 1:
		self.visible = true


func _on_slider_value_changed(value: float) -> void:
#   slider changed value
	var linear_value = clamp(value / 100.0, 0.0, 1.0)
	AudioServer.set_bus_volume_db(master, linear_to_db(linear_value))

func set_slider_colors(track: Color, fill: Color) -> void:
	var track_sb = s.get_theme_stylebox("slider").duplicate()
	track_sb.bg_color = track
	s.add_theme_stylebox_override("slider", track_sb)
	
	var fill_sb = s.get_theme_stylebox("grabber_area").duplicate()
	fill_sb.bg_color = fill
	s.add_theme_stylebox_override("grabber_area", fill_sb)


func _on_button_pressed() -> void:
	self.visible = false
