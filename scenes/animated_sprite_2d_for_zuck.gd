extends AnimatedSprite2D


func _on_animation_changed():
	if animation == "jumping" or animation == "default":
		scale = Vector2(.3,.3)
	elif animation == "running":
		scale = Vector2(.5,.5)
	else:
		scale = Vector2(1.0,1.0)
