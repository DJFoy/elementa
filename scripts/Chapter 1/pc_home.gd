extends Location

@onready var spawn_door: Marker2D = $SpawnDoor
@onready var spawn_stairs: Marker2D = $SpawnStairs
@onready var dad: Non_Player_Character = $Dad
@onready var dad_sprite := preload("res://resources/character_sprite_tilesets/dad_sprite.tres")

func _ready() -> void:
	spawns = {
		"PlayerInit": spawn_stairs,
		"PlayerBBVillage": spawn_door,
		"PCBedroom": spawn_stairs
	}
	dad.get_node("Sprite2D").texture = dad_sprite
	super()
	dialogues = {
		dad: [
			["Dad", "Morning, " + PLAYER_DATA.name + ". How are you feeling?"],
			["Dad", "Are you ready for your first day of work?"],
			[PLAYER_DATA.name, "..."],
			["Dad", "Hey, I know you had your heart set on that scholarship. Working as a servant in the manor won't be all that bad, though. At least you won't have to work in the mines like I did."],
			["Option", ["Right... I get to watch people like Gigi and George become adventurers while I sit at home and dust their silverware", "Yeah. I guess it could be worse"]],
			["Dad", "I'm sorry " + PLAYER_DATA.name + ". I know it's unfair that nobles are often the only ones that get to become adventurers. I would give you the money if we had it. But, I mean, we can't even afford a Familiar for the house..."]
		]
	}

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
