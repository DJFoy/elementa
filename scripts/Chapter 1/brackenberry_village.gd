extends Location

func _setup_location() -> void:
	cutscenes = {}
	
	cutscene_rules = []
	
	npcs = [
		{
			"npc_id": "NPC_BBV_1",
			"npc_location": Vector2(-88, -24),
			"spawn_conds": [
					]
		},
		{
			"npc_id": "NPC_BBV_2",
			"npc_location": Vector2(-104, -24),
			"spawn_conds": [
					]
		},
		{
			"npc_id": "NPC_BBV_3",
			"npc_location": Vector2(152, -8),
			"spawn_conds": [
					]
		},
		{
			"npc_id": "NPC_BBV_4",
			"npc_location": Vector2(248, -8),
			"spawn_conds": [
					]
		}
	]
