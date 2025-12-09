extends Camera2D

var default_zoom = Vector2(1,1)
var zoomed_in = Vector2(0.5, 0.5)
var zoom_speed = 0.1

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if zoom == default_zoom:
			zoom = zoomed_in
		else:
			zoom = default_zoom
#will add movement for achievements...: 
func _process(delta):
	if Input.is_action_pressed("zoom_in"):
		zoom = zoom.lerp(zoomed_in, zoom_speed)
	elif Input.is_action_pressed("zoomed_in"):
		zoom = zoom.lerp(default_zoom, zoom_speed)
