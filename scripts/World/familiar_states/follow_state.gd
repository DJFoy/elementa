extends State

func Enter() -> void:
	owner.target.character_moving.connect(_on_target_moving)
	owner.idle_request.connect(_on_stop_following)

func Exit() -> void:
	owner.target.character_moving.disconnect(_on_target_moving)
	owner.idle_request.disconnect(_on_stop_following)

func _on_target_moving(dir: Vector2) -> void:
	owner.force_move(dir)

func _on_stop_following() -> void:
	Transitioned.emit(self, "idle")
