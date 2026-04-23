extends Location

@onready var dad: Non_Player_Character = $NPCs/Dad

@onready var background: TileMapLayer = $TileMaps/Background
@onready var furniture: TileMapLayer = $TileMaps/Furniture

@onready var window: Marker2D = $CutsceneMarkers/Window
@onready var counter: Marker2D = $CutsceneMarkers/Counter
@onready var peek: Marker2D = $CutsceneMarkers/Peek
@onready var leave: Marker2D = $CutsceneMarkers/Leave

func _setup_location() -> void:
	
	EventBus.open_window.connect(_on_open_window_requested)
	
	cutscenes = {
		"chapter1_dad_intro": [
				CH.say("chapter1_dadIntro"),
				CH.spawn(
					preload("res://scenes/chapter1/locations/bird.tscn"),
					"chapter1_bird",
					Vector2(32,40),
					get_node("NPCs"),
					{
						"window": window,
						"counter": counter,
						"peek": peek,
						"leave": leave
					}),
				CH.turn("Dad", Vector2.UP),
				CH.animation("chapter1_bird", "bird_peek"),
				CH.animation("chapter1_bird", "bird_enter"),
				CH.turn("Dad", Vector2.LEFT),
				CH.animation("chapter1_bird", "bird_drop"),
				CH.spawn(
					preload("res://scenes/chapter1/locations/scroll.tscn"),
					"chapter1_scroll",
					counter.global_position,
					get_node("NPCs"),
					{}
				),
				CH.wait(1),
				CH.animation("chapter1_bird", "bird_leave"),
				CH.move("Dad", Vector2.LEFT),
				CH.turn("Dad", Vector2.UP),
				CH.say("chapter1_dadIntro_2"),
				CH.turn("Dad", Vector2.DOWN)
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

func _on_open_window_requested() -> void:
	background.set_cell(Vector2i(3,-2), 0, Vector2i(11,8))
	furniture.set_cell(Vector2i(3,-2), 0, Vector2i(12,8))
