extends Node

var registry := {}

func _ready() -> void:
	EventBus.register_actor.connect(_on_register_actor_request)
	EventBus.world_change_request.connect(_on_world_change_request)

func register_actor(id: String, actor: Node):
	registry[id] = actor

func get_actor(id: String):
	return registry[id]

func clear_actor(id: String) -> void:
	registry.erase(id)

func _on_register_actor_request(actor_id: String, actor: Node) -> void:
	if registry.has(actor_id):
		printerr("Actor ID, Key %s, already exists" % actor_id)
		return
	register_actor(actor_id, actor)

func _on_world_change_request() -> void:
	registry.clear()
