extends Location

@onready var spawn_door: Spawn = $EntryPoints/SpawnDoor
@onready var exit_door: ExitArea = $Exits/ExitDoor
@onready var exit_stairs: ExitArea = $Exits/ExitStairs

@onready var bbv_4: Marker2D = $NPCs/BBV4

func _setup_location() -> void:
	npcs = [
		{
			"npc_id": "NPC_BBV_4",
			"npc_location": bbv_4.global_position,
			"default_direction": Vector2.LEFT,
			"spawn_conds": [
					]
		}
	]
	locked_doors = [
		{
			"door": exit_stairs,
			"unlock": [func(): return false]
		}
	]
