extends CutsceneStep
class_name DialogueStep

@export var dialogue_id: String

func run(director):
	await director.ui._cutscene_start_dialogue_ui(dialogue_id)
