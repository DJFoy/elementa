extends Node
class_name CutsceneManager

signal cutscene_finished(cutscene_id: String)
@onready var ui: CanvasLayer = $"../UI"

func play_cutscene(sequence: Array, cutscene_id: String) -> void:
	if GameState.interacting:
		return
	GameState.interacting = true
	GameState.lock()
	await _run_sequence(sequence, cutscene_id)
	GameState.interacting = false
	GameState.unlock()
	EventBus.emit_signal("cutscene_finished", cutscene_id)

func _run_sequence(sequence: Array, cutscene_id: String):
	for step in sequence:
		await step.run(self)
