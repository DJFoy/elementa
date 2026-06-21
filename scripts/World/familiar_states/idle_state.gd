extends State

func Enter():
	owner.follow_request.connect(_on_start_following)
	owner.collision_layer = 3

func Exit():
	owner.follow_request.disconnect(_on_start_following)

func _on_start_following() -> void:
	Transitioned.emit(self, "following")
