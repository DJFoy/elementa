extends CutsceneStep
class_name TurnStep

var actor: Character

@export var direction: Vector2

func run(director):
	actor.direction_change(direction)
