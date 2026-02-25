extends Control

@export var line_presenter: Control
@export var dialogue_runner: DialogueRunner

signal request_next_line
signal request_dialogue_end

func _ready() -> void:
	Global.interacting = true
	line_presenter.connect("dialogue_complete", _on_dialogue_complete)
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		emit_signal("request_next_line")

func _on_dialogue_complete() -> void:
	print("Requesting to end the dialogue!")
	emit_signal("request_dialogue_end")
