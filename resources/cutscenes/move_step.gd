extends CutsceneStep
class_name MoveStep

var actor: Character

@export var direction: Vector2
@export var wait_to_finish:= true

func run(director):
	if wait_to_finish:
		await actor.move(direction)
	else:
		actor.move(direction)
