extends CutsceneStep
class_name SpawnStep

@export var scene: PackedScene
@export var position: Vector2
var parent: Node
@export var setup: Dictionary = {}

func run(director):
	var instance = scene.instantiate()
	parent.add_child(instance)
	instance.global_position = position
	
	for key in setup:
		instance.set(key, setup[key])
