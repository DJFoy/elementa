extends CutsceneStep

class_name AnimationStep

var anim: Node2D

func run(director):
	await anim.play_animation()
