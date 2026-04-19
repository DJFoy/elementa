extends CutsceneStep
class_name MoveStep

var actor_id: String

@export var direction: Vector2
@export var wait_to_finish:= true

func run(director: CutsceneManager):
	var actor = director.get_actor(actor_id)
	
	if wait_to_finish:
		await actor.move(direction)
	else:
		actor.move(direction)
