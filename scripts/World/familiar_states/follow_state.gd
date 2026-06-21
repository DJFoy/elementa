extends State

func Enter() -> void:
	owner.target.character_moving.connect(_on_target_moving)
	owner.idle_request.connect(_on_stop_following)
	owner.collision_layer = 0

func Exit() -> void:
	owner.target.character_moving.disconnect(_on_target_moving)
	owner.idle_request.disconnect(_on_stop_following)

func _on_target_moving() -> void:
	var dest: Vector2 = owner.target.global_position
	var current: Vector2 = owner.global_position
	
	var dir = current.direction_to(dest).round()
	owner.force_move(dir)

func _on_stop_following() -> void:
	Transitioned.emit(self, "idle")

func Update(_delta: float):
	owner.wants_to_move = owner.target.wants_to_move
		
	var dest: Vector2 = owner.target.global_position
	var current: Vector2 = owner.global_position
	
	var dir = current.direction_to(dest).round()
	owner.wants_to_move_dir = dir
