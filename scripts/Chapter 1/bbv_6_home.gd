extends Location

@onready var exit_stairs: ExitArea = $Exits/ExitStairs
@onready var bbv_5: Marker2D = $NPCs/BBV5

func _setup_location() -> void:
	npcs = [
		{
			"npc_id": "NPC_BBV_5",
			"npc_location": bbv_5.global_position,
			"default_direction": Vector2.UP,
			"spawn_conds": []
		}
	]
	
	locked_doors = [
		{
			"door": exit_stairs,
			"unlock": [func(): return false]
		}
	]
