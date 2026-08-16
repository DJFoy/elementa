extends Control

class_name LoadGameTile

@onready var character_name: Label = $Panel/HBoxContainer/GameDetails/CharacterName
@onready var familiar_name: Label = $Panel/HBoxContainer/GameDetails/FamiliarName
@onready var current_chapter: Label = $Panel/HBoxContainer/GameDetails/CurrentChapter
@onready var time_played: Label = $Panel/HBoxContainer/GameDetails/TimePlayed

@export var save_slot: String

signal load_game

func initialise_tile(loaded_character_name: String, loaded_familiar_name: String, loaded_chapter: String, loaded_time_played: String, slot: String):
	character_name.text += " " + loaded_character_name
	familiar_name.text += " " + loaded_familiar_name
	current_chapter.text += " " + loaded_chapter
	time_played.text += " " + loaded_time_played
	
	save_slot = slot


func _on_load_pressed() -> void:
	GameState.game_loaded = true
	
	var world_save: WorldStateSave = WorldStateSave.load(save_slot)
	
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
	
	GameState.target_spawn = "Loaded_Spawn"
	GameState.target_vec = world_save.last_location
	GameState.familiar_vec = world_save.fam_last_location
	
	if Global_World_State.familiar:
		Global_World_State.familiar.chosen_familiar = true
	
	load_game.emit(world_save.current_scene)

func _on_delete_pressed() -> void:
	pass # Replace with function body.
