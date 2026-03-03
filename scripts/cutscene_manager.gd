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
		print(step)
		match step["type"]:
			"dialogue":
				await ui._cutscene_start_dialogue_ui(step["dialogue_id"])
				print("Director says the dialogue finished, next step!")
			"move":
				print("Actor please!")
				if step["await"]:
					await step["actor"].move(step.dir)
				else:
					step["actor"].move(step.dir)
			"camera":
				pass
			"fade":
				match step["transition_type"]:
					"fade_in":
						
