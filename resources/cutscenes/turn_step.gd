extends CutsceneStep
class_name TurnStep

var actor_id: String

@export var direction: Vector2

func run(director: CutsceneManager):
	var actor = director.get_actor(actor_id)
	
	actor.direction_change(direction)
