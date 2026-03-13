extends Node
class_name CutsceneManager

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
			"action":
				match step["action"]:
					"move":
						print("Actor please!")
						if step["await"]:
							print("await the move")
							await step["actor"].move(step["dir"])
						else:
							step["actor"].move(step["dir"])
					"direction":
						step["actor"].direction_change(step["dir"])
			"camera":
				pass
			"transition":
				print(step["transition_type"])
				match step["transition_type"]:
					"fade_in":
						await SceneTransition.fade_in(step["duration"])
					"fade_out":
						await SceneTransition.fade_out(step["duration"])
	EventBus.emit_signal("cutscene_finished")
