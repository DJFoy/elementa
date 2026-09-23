extends Control
@onready var v_box_container: VBoxContainer = $Panel/VBoxContainer/ScrollContainer/VBoxContainer


func _ready() -> void:
	initialise_menu()

func initialise_menu() -> void:
	var slots: Array[String]
	
	if DirAccess.dir_exists_absolute("user://save"):
		var save_dir = DirAccess.open("user://save")
		
		var saves: PackedStringArray = save_dir.get_directories()
		
		for folder in saves:
			slots.append(folder.replace("slot_", ""))
		
		print(slots)
		
		var save_tile_scene = preload("res://scenes/UI/save_game_tile.tscn")
		
		for slot in slots:
			var save_tile: SaveGameTile = save_tile_scene.instantiate()
			save_tile.custom_minimum_size = Vector2(408, 81)
			v_box_container.add_child(save_tile)
			await get_tree().process_frame
			initialise_save_tile(save_tile, slot)
	else:
		printerr("Cannot find user save directory")

func initialise_save_tile(save_tile: SaveGameTile, save_slot: String):
	var save_details = WorldStateSave.load(save_slot)
	
	var character_name = save_details.character.name
	var familiar_name: String
	if save_details.familiar:
		familiar_name = save_details.familiar.npc_name
	else:
		familiar_name = ""
	var chapter = save_details.chapter
	var time_played = ""
	
	save_tile.initialise_tile(character_name, familiar_name, chapter, time_played, save_slot)
	
	save_tile.save_game.connect(_on_game_saved)

func _on_game_saved():
	for child in v_box_container.get_children():
		v_box_container.remove_child(child)
		
		child.queue_free()
	
	initialise_menu()


func _on_button_pressed() -> void:
	var new_slot = create_unique_string()
	print(new_slot)
	
	GameState.current_slot = new_slot
	
	var world_save := WorldStateSave.load(new_slot)
	world_save.character = Global_World_State.character
	world_save.familiar = Global_World_State.familiar
	world_save.familiar_chosen = Global_World_State.familiar_chosen
	
	world_save.chapter = Global_World_State.chapter
	world_save.cutscenes = Global_World_State.cutscenes
	world_save.items_collected = Global_World_State.items_collected
	world_save.one_time_dialogues = Global_World_State.one_time_dialogues
	world_save.significant_events = Global_World_State.significant_events
	
	world_save.current_scene = Global_World_State.current_scene
	world_save.last_location = Global_World_State.last_location
	world_save.fam_last_location = Global_World_State.fam_last_location
	
	world_save.save()
	
	print("Game Saved")
	
	_on_game_saved()

func generate_string() -> String:
	const chars = "abcdefghijklmnopqrstuv0123456789"
	
	var output_string = ""
	
	for i in range(16):
		output_string += chars[randi() % chars.length()]
	
	return output_string

func verify_unique(save_key: String) -> bool:
	var check_var:= true
	
	if DirAccess.dir_exists_absolute("user://save"):
		var save_dir = DirAccess.open("user://save")
		
		var saves: PackedStringArray = save_dir.get_directories()
		
		for folder in saves:
			if folder.replace("slot_", "") == save_key:
				check_var = false
	
	return check_var

func create_unique_string() -> String:
	var unique_string_generated:= false
	
	var current_key: String
	
	while !unique_string_generated:
		current_key = generate_string()
		if verify_unique(current_key):
			unique_string_generated = true
	
	return current_key
		


func _on_test_pressed() -> void:
	print(create_unique_string()) # Replace with function body.


func _on_back_pressed() -> void:
	GameState.unlock()
	GameState.interacting = false
	self.queue_free()
