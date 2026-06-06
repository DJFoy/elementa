extends State

@export var target: Character
@onready var familiar = owner

func Enter() -> void:
	target.character_moving.connect(_on_target_moving)

func Exit() -> void:
	target.character_moving.disconnect(_on_target_moving)

func _on_target_moving(dir: Vector2) -> void:
	owner.force_move(dir)
