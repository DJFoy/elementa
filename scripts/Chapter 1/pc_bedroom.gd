extends Location

@onready var uniform: Sprite2D = $Uniform
@onready var test_dest: Marker2D = $Destinations/TestDest

func _setup_location() -> void:
	var player_data = ResourceLoader.load("res://saves/player_data.tres")
	cutscenes = {
		"pc_bedroom_intro": [
				CH.say("chapter1_openingScene"),
				CH.transition(TransitionStep.TransitionType.FADE_IN, 2),
 				CH.move(self, "Player_Character", test_dest.global_position)
			]
		}
	cutscene_rules = [
		{
		"id": "pc_bedroom_intro",
		"trigger": "on_enter",
		"target": "",
		"conditions": [func(): return !Global_World_State.cutscenes.has("pc_bedroom_intro")]
		}
	]
	uniform.texture = load("res://assets/locations/brackenberry village/player home/body_type_%d.png" % [player_data.body_type])
	
