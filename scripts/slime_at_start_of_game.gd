extends CharacterBody2D

@onready var dialog: Node = %Dialog
@onready var dia = %Dialog
@onready var dialog_indicator: TextureRect = %DialogIndicator
var dialog_inTalkRange

func _ready() -> void:	
	dialog_indicator.hide()
func _on_talk_range_body_entered(body: Node2D) -> void:
	if body.name.contains("Zuck") or body.is_in_group("player"):
		dialog_indicator.show()
		dialog.inTalkRange = true
func _on_talk_range_body_exited(body: Node2D) -> void:
	if body.name.contains("Zuck") or body.is_in_group("player"):
		dialog_indicator.hide()
		dialog.inTalkRange = false
