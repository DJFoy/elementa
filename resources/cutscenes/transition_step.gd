extends CutsceneStep
class_name TransitionStep

enum TransitionType { FADE_IN, FADE_OUT }

@export var transition: TransitionType
@export var duration := 0.3

func run(director):
	match transition:
		TransitionType.FADE_IN:
			await SceneTransition.fade_in(duration)
		TransitionType.FADE_OUT:
			await SceneTransition.fade_out(duration)
