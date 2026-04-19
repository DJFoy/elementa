extends CutsceneStep
class_name WaitStep

@export var duration: float

func run(director: CutsceneManager):
	await director.get_tree().create_timer(duration).timeout
