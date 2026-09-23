extends Control

class_name SaveGameTile

@onready var character_name: Label = $Panel/HBoxContainer/GameDetails/CharacterName
@onready var familiar_name: Label = $Panel/HBoxContainer/GameDetails/FamiliarName
@onready var current_chapter: Label = $Panel/HBoxContainer/GameDetails/CurrentChapter
@onready var time_played: Label = $Panel/HBoxContainer/GameDetails/TimePlayed

@export var save_slot: String

signal save_game

func initialise_tile(loaded_character_name: String, loaded_familiar_name: String, loaded_chapter: String, loaded_time_played: String, slot: String):
	character_name.text += " " + loaded_character_name
	familiar_name.text += " " + loaded_familiar_name
	current_chapter.text += " " + loaded_chapter
	time_played.text += " " + loaded_time_played
	
	save_slot = slot


func _on_save_pressed() -> void:
	var world_save := WorldStateSave.load(save_slot)
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
	
	print("Game Saved at slot %s" % [save_slot])
	
	save_game.emit()

func _on_delete_pressed() -> void:
	pass # Replace with function body.
