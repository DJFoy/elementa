extends CutsceneStep

class_name AnimationStep

var actor_id: String
@export var anim_id: String

func run(director: CutsceneManager):
	var anim = director.get_actor(actor_id)
	
	await anim.play_animation(anim_id)
