extends CutsceneStep

class_name AnimationStep

var anim: Node2D
@export var anim_id: String

func run(director):
	await anim.play_animation(anim_id)
