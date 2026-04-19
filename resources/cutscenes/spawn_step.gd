extends CutsceneStep
class_name SpawnStep

@export var scene: PackedScene
@export var actor_id: String
@export var position: Vector2
var parent: Node
@export var setup: Dictionary = {}

func run(director: CutsceneManager):
	var instance = scene.instantiate()
	parent.add_child(instance)
	instance.global_position = position
	
	director.register_actor(actor_id, instance)
	
	for key in setup:
		instance.set(key, setup[key])
