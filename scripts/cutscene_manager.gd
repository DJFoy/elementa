extends Node

signal cutscene_finished
@onready var ui: CanvasLayer = $"../UI"

func play_cutscene(sequence: Array) -> void:
	if Global.interacting:
		return
	Global.interacting = true
	await _run_sequence(sequence)
	Global.interacting = false
	emit_signal("cutscene_finished")

func _run_sequence(sequence: Array):
	for step in sequence:
		match step.type:
			"dialogue":
				await ui.cutscene_start_dialogue_ui(step.dialogue_id)
			"actor":
				await step.actor.move(step.dir)
			"camera":
				pass
