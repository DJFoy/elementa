extends Control

@export var line_presenter: Control
@export var dialogue_runner: DialogueRunner

signal request_next_line
signal request_dialogue_end

func _ready() -> void:
	Global.interacting = true
	line_presenter.connect("dialogue_complete", _on_dialogue_complete)
	_sync_game_and_yarn()
	

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		emit_signal("request_next_line")
		get_viewport().set_input_as_handled()

func _on_dialogue_complete() -> void:
	print("Requesting to end the dialogue!")
	emit_signal("request_dialogue_end")

func _sync_game_and_yarn() -> void:
	var vars = dialogue_runner.variableStorage
	vars.SetValue("$playerName", Global_World_State.character.name)
	vars.SetValue("$hatedFood", Global_World_State.character.dislikes)
