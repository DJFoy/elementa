extends Location

@onready var spawn_door: Marker2D = $SpawnDoor
@onready var spawn_stairs: Marker2D = $SpawnStairs

func _ready() -> void:
	spawns = {
		"PlayerBBVillage": spawn_door,
		"PCBedroom": spawn_stairs
	}
	super()

func _on_exit_stairs_body_entered(body: Node2D) -> void:
	if body.is_class("CharacterBody2D"):
		get_node("/root/Global").prev_scene = "PCHome"
		get_tree().change_scene_to_file("res://scenes/chapter1/locations/pc_bedroom.tscn")


func _on_exit_stairs_2_body_exited(body: Node2D) -> void:
	leave_trans_area()
