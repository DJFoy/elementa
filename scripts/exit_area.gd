extends Area2D
class_name ExitArea

@export_file("*.tscn") var target_scene
@export var target_spawn: String

signal exit_requested(from_scene: String, target_scene: String, target_spawn: String)

var armed := false

func _ready() -> void:
	add_to_group("Exits")
	monitoring = true
	armed = false
	
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node2D) -> void:
	if !armed:
		return
	if body is Player_Character:
		exit_requested.emit(
			get_parent().name,
			target_scene,
			target_spawn
		)

func _on_body_exited(body: Node2D) -> void:
	if body is Player_Character:
		armed = true
