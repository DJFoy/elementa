extends CutsceneStep
class_name DespawnStep

@export var actor_id: String

func run(director: CutsceneManager) -> void:
	var actor = ActorManager.get_actor(actor_id)
	
	actor.queue_free()
	ActorManager.clear_actor(actor_id)
