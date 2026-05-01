extends Node

# This global is for the world state - keep a collection of world actions that need to be retained for gameplay

# Store the current character resource
# Can be set either by player_init or by load
var character

func get_character_portrait_variant(character_name: String) -> String:
	# Used by the portrait presenter, needs to access the player character resource for checking skin tone
	match character_name:
		"dad":
			return "_%d" % [character.skin_colour]
		_:
			return ""

# Store current chapter of the game, a flag for various story based options
var chapter:= "Chapter1"

# Store all one time dialogues that have been completed
var one_time_dialogues:= []

# Track items collected around the world to prevent them spawning
var items_collected:= []

# Store which cutscenes have been played so as to prevent them repeating
var cutscenes:= []
