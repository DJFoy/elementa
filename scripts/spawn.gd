extends Marker2D
class_name Spawn

@export var spawn_name: String

func _ready() -> void:
	add_to_group("Spawns")
