extends Control
signal world_change_request


func _ready() -> void:
	SceneTransition.fade_in()


func _on_new_game_pressed() -> void:
	world_change_request.emit("res://scenes/UI/player_init.tscn")


func _on_load_game_pressed() -> void:
	GameState.game_loaded = true
	
	var world_save: WorldStateSave = WorldStateSave.load()
	
	var valid_properties := {}
	
	for prop in Global_World_State.get_property_list():
		valid_properties[prop.name] = true
	
	for prop in world_save.get_property_list():
		var property_name = prop.name
		
		if prop.usage & PROPERTY_USAGE_SCRIPT_VARIABLE == 0:
			continue
		if valid_properties.has(property_name):
			Global_World_State.set(
				property_name,
				world_save.get(property_name)
			)
	
	Global_World_State.character = ResourceLoader.load("res://saves/player_data.tres")
	GameState.target_spawn = "Loaded_Spawn"
	GameState.target_vec = world_save.last_location
	world_change_request.emit(world_save.current_scene)


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_exit_pressed() -> void:
	get_tree().quit() # Replace with function body.


func _on_debug_pressed() -> void:
	world_change_request.emit("res://scenes/UI/debug.tscn")
