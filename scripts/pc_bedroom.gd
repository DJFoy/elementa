extends Location

@onready var pc_load:= preload("res://scenes/pc.tscn")
@onready var pc: Player_Character

@onready var player_data: PlayerCreationData

func _ready() -> void:
	player_data = ResourceLoader.load("res://saves/player_data.tres")
	print("Opening the room")
	print(player_data.name + " the one, the only")
	pc = pc_load.instantiate()
	pc.character_data = player_data
	add_child(pc)
