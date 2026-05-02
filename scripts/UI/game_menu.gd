extends Control


func _on_save_pressed() -> void:
	save_game()


func save_game() -> void:
	var world_save := WorldStateSave.load()
	world_save.chapter = Global_World_State.chapter
	world_save.cutscenes = Global_World_State.cutscenes
	world_save.items_collected = Global_World_State.items_collected
	world_save.one_time_dialogues = Global_World_State.one_time_dialogues
	
	world_save.current_scene = Global_World_State.current_scene
	world_save.last_location = Global_World_State.last_location
