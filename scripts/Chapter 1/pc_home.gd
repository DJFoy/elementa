extends Location
@onready var dad: Non_Player_Character = $NPCs/Dad

func _setup_location() -> void:
	cutscenes = {
		"chpater1_dad_intro":
			[
				CH.say("chapter1_dadIntro"),
				CH.animation("bird_enter")
			]
	}
	cutscene_rules = [
		{
		"id": "chapter1_dad_intro",
		"trigger": "on_interact",
		"target": dad,
		"conditions": [!Global_World_State.cutscenes.has("chapter1_dad_intro")]
		}
	]
