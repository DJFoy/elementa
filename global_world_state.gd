extends Node

# This global is for the world state - keep a collection of world actions that need to be retained for gameplay

# Store the current character resource
# Can be set either by player_init or by load
var character: PlayerCreationData
var familiar: NPC_Resource

var familiar_chosen: String

func get_character_portrait_variant(character_name: String) -> String:
	# Used by the portrait presenter, needs to access the player character resource for checking skin tone
	match character_name:
		"dad":
			return "_%d" % [character.skin_colour]
		_:
			return ""

# Store current chapter of the game, a flag for various story based options
var chapter:= "Chapter1"

# Store the current location scene and coordinates that the character is in (for loading purposes)
var current_scene: String
var last_location: Vector2

# Store all one time dialogues that have been completed
var one_time_dialogues:= []

# Track items collected around the world to prevent them spawning
var items_collected:= []

# Store which cutscenes have been played so as to prevent them repeating
var cutscenes:= []

# Store major game events as strings, such as collecting your familiar (so a familiar should appear behind the PC)
var significant_events = []
