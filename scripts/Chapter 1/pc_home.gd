extends Location

@onready var dad: Non_Player_Character = $NPCs/Dad

@onready var background: TileMapLayer = $TileMaps/Background
@onready var furniture: TileMapLayer = $TileMaps/Furniture

@onready var window: Marker2D = $CutsceneMarkers/Window
@onready var counter: Marker2D = $CutsceneMarkers/Counter
@onready var peek: Marker2D = $CutsceneMarkers/Peek
@onready var leave: Marker2D = $CutsceneMarkers/Leave
@onready var play_cue_ch_1_chair: Marker2D = $CutsceneMarkers/PlayCueCh1Chair
@onready var dad_cue_ch_1_table: Marker2D = $CutsceneMarkers/DadCueCh1Table
@onready var dad_cue_ch_1_worktop: Marker2D = $CutsceneMarkers/DadCueCh1Worktop

func _setup_location() -> void:
	
	print(navigation.astar.get_point_path(navigation.cell_to_id[[Vector2i(1,1), navigation.Dir.UP]], navigation.cell_to_id[[Vector2i(1,0), navigation.Dir.UP]]))
	
	EventBus.open_window.connect(_on_open_window_requested)
	
	cutscenes = {
		"chapter1_dad_intro": [
				CH.say("chapter1_dadIntro"),
				CH.move(self, "Dad", dad_cue_ch_1_table.global_position, false),
				CH.move(self, "Player_Character", play_cue_ch_1_chair.global_position),
				CH.say("chatper1_dadBreakfast"),
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
				CH.animation("chapter1_bird", "bird_peek"),
				CH.turn("Dad", Vector2.UP),
				CH.animation("chapter1_bird", "bird_enter"),
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
				CH.move(self, "Dad", dad_cue_ch_1_worktop.global_position),
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
	background.set_cell(Vector2i(3,-1), 0, Vector2i(11,9))
	furniture.set_cell(Vector2i(3,-2), 0, Vector2i(12,8))
	furniture.set_cell(Vector2i(3,-1), 0, Vector2i(12,9))
