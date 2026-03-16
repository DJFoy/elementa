extends Node
class_name CutsceneManager

signal cutscene_finished(cutscene_id: String)
@onready var ui: CanvasLayer = $"../UI"

func play_cutscene(sequence: Array, cutscene_id: String) -> void:
	if Global.interacting:
		return
	Global.interacting = true
	await _run_sequence(sequence, cutscene_id)
	Global.interacting = false
	emit_signal("cutscene_finished", cutscene_id)

func _run_sequence(sequence: Array, cutscene_id: String):
	for step in sequence:
		await step.run(self)
	
	EventBus.emit_signal("cutscene_finished", cutscene_id)
