extends Control

class_name LoadGameTile

@onready var character_name: Label = $Panel/HBoxContainer/GameDetails/CharacterName
@onready var familiar_name: Label = $Panel/HBoxContainer/GameDetails/FamiliarName
@onready var current_chapter: Label = $Panel/HBoxContainer/GameDetails/CurrentChapter
@onready var time_played: Label = $Panel/HBoxContainer/GameDetails/TimePlayed

func initialise_tile(loaded_character_name: String, loaded_familiar_name: String, loaded_chapter: String, loaded_time_played: String):
	character_name.text += " " + loaded_character_name
	familiar_name.text += " " + loaded_familiar_name
	current_chapter.text += " " + loaded_chapter
	time_played.text += " " + loaded_time_played
	
