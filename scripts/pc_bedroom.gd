extends Location


@onready var spawn_init: Marker2D = $SpawnInit
@onready var spawn_stairs: Marker2D = $SpawnStairs

func _ready() -> void:
	spawns = {
		"PlayerInit": spawn_init,
		"PCHome": spawn_stairs
	}
	super()
	if prev_scene == "PlayerInit":
		leave_trans_area()


func _on_exit_stairs_body_entered(body: Node2D) -> void:
	if body is PC:
		trigger_exit("PCBedroom", "res://scenes/chapter1/locations/pc_home.tscn")


func _on_exit_stairs_2_body_exited(body: Node2D) -> void:
	leave_trans_area()
