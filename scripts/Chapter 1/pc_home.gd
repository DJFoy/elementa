extends Location

@onready var dad: Non_Player_Character = $NPCs/Dad

@onready var background: TileMapLayer = $TileMaps/Background
@onready var furniture: TileMapLayer = $TileMaps/Furniture
@onready var sink: TileMapLayer = $TileMaps/Sink

@onready var window: Marker2D = $CutsceneMarkers/Window
@onready var counter: Marker2D = $CutsceneMarkers/Counter
@onready var peek: Marker2D = $CutsceneMarkers/Peek
@onready var leave: Marker2D = $CutsceneMarkers/Leave
@onready var play_cue_ch_1_chair: Marker2D = $CutsceneMarkers/PlayCueCh1Chair
@onready var dad_cue_ch_1_table: Marker2D = $CutsceneMarkers/DadCueCh1Table
@onready var dad_cue_ch_1_worktop: Marker2D = $CutsceneMarkers/DadCueCh1Worktop
@onready var dad_cue_ch_1_chair: Marker2D = $CutsceneMarkers/DadCueCh1Chair
@onready var spawn_door: Spawn = $EntryPoints/SpawnDoor

@onready var exit_stairs: ExitArea = $Exits/ExitStairs
@onready var exit_door: ExitArea = $Exits/ExitDoor

func _setup_location() -> void:
	
	EventBus.open_window.connect(_on_open_window_requested)
	
	cutscenes = {
		"chapter1_dad_intro": [
				CH.say("chapter1_dadIntro"),
				CH.turn("Dad", Vector2.UP),
				CH.move(self, "Player_Character", play_cue_ch_1_chair.global_position),
				CH.turn("Player_Character", Vector2.LEFT),
				CH.move(self, "Dad", dad_cue_ch_1_table.global_position),
				CH.turn("Dad", Vector2.DOWN),
				CH.change_tilemap(sink, Vector2i(1,2), Vector2i(1,2), ChangeTileMapStep.Transform.FLIP_H),
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
				CH.turn("Player_Character", Vector2.UP),
				CH.emote(["Player_Character", "Dad"], EmoteLibrary.shocked),
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
				CH.despawn("chapter1_scroll"),
				CH.say("chapter1_dadIntro_2"),
				CH.move(self, "Dad", dad_cue_ch_1_chair.global_position),
				CH.turn("Dad", Vector2.DOWN),
				CH.turn("Player_Character", Vector2.UP),
				CH.wait(2),
				CH.say("chapter1_dadIntro_3"),
				CH.move(self, "Dad", spawn_door.global_position),
				CH.despawn("Dad")
			]
	}
	cutscene_rules = [
		{
		"id": "chapter1_dad_intro",
		"trigger": "on_interact",
		"target": "Dad",
		"conditions": [func(): return !Global_World_State.cutscenes.has("chapter1_dad_intro")]
		}
	]
	locked_doors = [
		{
			"door": exit_door,
			"unlock": [func(): 
				return Global_World_State.cutscenes.has("chapter1_dad_intro")]
		}
	]
	npcs = [
		{
			"npc_id": "Dad"
		}
	]

func _on_open_window_requested() -> void:
	background.set_cell(Vector2i(3,-2), 0, Vector2i(11,8))
	background.set_cell(Vector2i(3,-1), 0, Vector2i(11,9))
	furniture.set_cell(Vector2i(3,-2), 0, Vector2i(12,8))
	furniture.set_cell(Vector2i(3,-1), 0, Vector2i(12,9))
