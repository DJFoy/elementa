extends Location

@onready var bbv_1: Marker2D = $NPCs/BBV1
@onready var bbv_2: Marker2D = $NPCs/BBV2
@onready var bbv_3: Marker2D = $NPCs/BBV3
@onready var butler: Marker2D = $NPCs/Butler

@onready var npc_house_1: ExitArea = $Exits/NPCHouse1
@onready var npc_house_3: ExitArea = $Exits/NPCHouse3
@onready var npc_house_5: ExitArea = $Exits/NPCHouse5
@onready var sullivan_manor_right: ExitArea = $Exits/SullivanManorRight


func _setup_location() -> void:
	cutscenes = {}
	
	cutscene_rules = []
	
	npcs = [
		{
			"npc_id": "NPC_BBV_1",
			"npc_location": bbv_1.global_position,
			"default_direction": Vector2.LEFT,
			"spawn_conds": [
					]
		},
		{
			"npc_id": "NPC_BBV_2",
			"npc_location": bbv_2.global_position,
			"default_direction": Vector2.RIGHT,
			"spawn_conds": [
					]
		},
		{
			"npc_id": "NPC_BBV_3",
			"npc_location": bbv_3.global_position,
			"default_direction": Vector2.DOWN,
			"spawn_conds": [
					]
		},
		{
			"npc_id": "Butler",
			"npc_location": butler.global_position,
			"default_direction": Vector2.DOWN,
			"spawn_conds": [
				func(): return !Global_World_State.cutscenes.has("chapter1_prof_olivia_intro")
					]
		}
	]
	
	locked_doors = [
		{
			"door": npc_house_1,
			"unlock": [func(): return false]
		},
		{
			"door": npc_house_3,
			"unlock": [func(): return false]
		},
		{
			"door": npc_house_5,
			"unlock": [func(): return false]
		},
		{
			"door": sullivan_manor_right,
			"unlock": [
				func(): return Global_World_State.cutscenes.has("chaper_1_prof_olivia_intro")
			]
		}
	]
