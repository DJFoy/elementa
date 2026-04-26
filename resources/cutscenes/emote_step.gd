extends CutsceneStep
class_name EmoteStep

var actor_id: String
@export var emote: EmoteResource

func run(director: CutsceneManager) -> void:
	var actor = director.get_actor(actor_id)
	
	await actor.trigger_emote(emote)
