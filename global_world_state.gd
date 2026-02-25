extends Node

# This global is for the world state - keep a collection of world actions that need to be retained for gameplay

var character:= ResourceLoader.load("res://saves/player_data.tres")

func get_character_portrait_variant(character_name: String) -> String:
	match character_name:
		"dad":
			return "_%d" % [character.skin_colour + 1]
		_:
			return ""

var chapter:= "Chapter1"

var one_time_dialogues:= []

var items_collected:= []
