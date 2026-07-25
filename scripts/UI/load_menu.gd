extends Control
@onready var v_box_container: VBoxContainer = $Panel/ScrollContainer/VBoxContainer

func _ready() -> void:
	var slots: Array[String]
	
	if DirAccess.dir_exists_absolute("user://save"):
		var save_dir = DirAccess.open("user://save")
		
		var saves: PackedStringArray = save_dir.get_directories()
		
		for folder in saves:
			slots.append(folder.replace("slot_", ""))
		
		print(slots)
		
		var load_tile_scene = preload("res://scenes/UI/load_game_tile.tscn")
		
		for slot in slots:
			var load_tile: LoadGameTile = load_tile_scene.instantiate()
			load_tile.custom_minimum_size = Vector2(408, 81)
			v_box_container.add_child(load_tile)
			await get_tree().process_frame
			initialise_load_tile(load_tile, slot)
	else:
		printerr("Cannot find user save directory")


func initialise_load_tile(load_tile: LoadGameTile, save_slot: String):
	var load_details = WorldStateSave.load(save_slot)
	
	var character_name = load_details.character.name
	var familiar_name = load_details.familiar.npc_name
	var chapter = load_details.chapter
	var time_played = ""
	
	load_tile.initialise_tile(character_name, familiar_name, chapter, time_played)
