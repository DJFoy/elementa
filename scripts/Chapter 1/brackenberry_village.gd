extends Location

func _setup_location() -> void:
	cutscenes = {}
	
	cutscene_rules = []
	
	npcs = [
		{
			"npc_id": "Villager 2",
			"npc_location": Vector2(-7, -2),
			"spawn_conds": [
					]
		}
	]
