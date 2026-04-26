extends CutsceneStep
class_name DespawnStep

@export var actor_id: String

func run(director: CutsceneManager) -> void:
	var actor = director.get_actor(actor_id)
	
	actor.queue_free()
	director.clear_actor(actor_id)
