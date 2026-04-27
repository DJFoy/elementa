extends Node
class_name CutsceneManager

signal cutscene_finished(cutscene_id: String)
@onready var ui: CanvasLayer = $"../UI"

var registry := {}

func _ready() -> void:
	EventBus.register_actor.connect(_on_register_actor_request)
	EventBus.world_change_request.connect(_on_world_change_request)

func play_cutscene(sequence: Array, cutscene_id: String) -> void:
	if Global.interacting:
		return
	Global.interacting = true
	Global.lock()
	await _run_sequence(sequence, cutscene_id)
	Global.interacting = false
	Global.unlock()
	EventBus.emit_signal("cutscene_finished", cutscene_id)

func _run_sequence(sequence: Array, cutscene_id: String):
	for step in sequence:
		await step.run(self)

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
