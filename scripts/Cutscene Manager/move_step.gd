extends CutsceneStep
class_name MoveStep

var actor_id: String
var location: Location

@export var destination: Vector2
@export var wait_to_finish:= true

func run(director: CutsceneManager):
	var actor = ActorManager.get_actor(actor_id)
	
	if wait_to_finish:
		location.path_move_requested(actor, actor.global_position, destination)
		await EventBus.movement_complete
	else:
		location.path_move_requested(actor, actor.global_position, destination)
