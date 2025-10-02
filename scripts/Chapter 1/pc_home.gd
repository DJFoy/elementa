extends Location

@onready var spawn_door: Marker2D = $SpawnDoor
@onready var spawn_stairs: Marker2D = $SpawnStairs
@onready var dad: Non_Player_Character = $Dad
@onready var dad_sprite := preload("res://resources/character_sprite_tilesets/dad_sprite.tres")

var dialogue: Array

func _ready() -> void:
	spawns = {
		"PlayerBBVillage": spawn_door,
		"PCBedroom": spawn_stairs
	}
	dad.get_node("Sprite2D").texture = dad_sprite
	super()

func _on_exit_stairs_body_entered(body: Node2D) -> void:
	if body is PC:
		trigger_exit("PCHome", "res://scenes/chapter1/locations/pc_bedroom.tscn")


func _on_exit_stairs_2_body_exited(body: Node2D) -> void:
	leave_trans_area()

func _on_exit_door_body_entered(body: Node2D) -> void:
	if body is PC:
		trigger_exit("PCHome", "res://scenes/chapter1/locations/brackenberry_village.tscn")

func _on_exit_door_2_body_exited(body: Node2D) -> void:
	leave_trans_area() 
