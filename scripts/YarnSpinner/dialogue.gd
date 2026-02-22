extends Control

signal request_next_line

func _ready() -> void:
	Global.interacting = true

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		emit_signal("request_next_line")
