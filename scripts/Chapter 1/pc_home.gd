extends Location
@onready var dad: Non_Player_Character = $NPCs/Dad
@onready var window: Marker2D = $CutsceneMarkers/Window
@onready var counter: Marker2D = $CutsceneMarkers/Counter
@onready var peek: Marker2D = $CutsceneMarkers/Peek

func _setup_location() -> void:
	cutscenes = {
		"chapter1_dad_intro": [
				CH.say("chapter1_dadIntro"),
				CH.spawn(
					preload("res://scenes/chapter1/locations/bird.tscn"),
					Vector2(32,40),
					get_node("NPCs"),
					{
						"window": window,
						"counter": counter,
						"peek": peek
					}),
				CH.animation($NPCs/Bird, "bird_enter"),
				CH.animation(get_node("NPCs/Bird"), "bird_drop")
			]
	}
	cutscene_rules = [
		{
		"id": "chapter1_dad_intro",
		"trigger": "on_interact",
		"target": dad.npc_resource.npc_name,
		"conditions": [func(): return !Global_World_State.cutscenes.has("chapter1_dad_intro")]
		}
	]
