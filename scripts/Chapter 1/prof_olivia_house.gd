extends Location

@onready var stairs: ExitArea = $Exits/Stairs
@onready var front_door_left: ExitArea = $Exits/FrontDoorLeft
@onready var front_door_right: ExitArea = $Exits/FrontDoorRight

@onready var prof_olivia: Marker2D = $NPCs/Prof_Olivia

func _setup_location() -> void:
	cutscenes = {}
	
	cutscene_rules = []
	
	locked_doors = [
		{
			"door": stairs,
			"unlock": [func(): return false]
		},
		{
			"door": front_door_left,
			"unlock": [func(): return Global_World_State.significant_events.has("familiar_confirmed")]
		},
		{
			"door": front_door_right,
			"unlock": [func(): return Global_World_State.significant_events.has("familiar_confirmed")]
		}
	]
	
	npcs = [
		{
			"npc_id": "Prof_Olivia",
			"npc_location": prof_olivia.global_position,
			"default_direction": Vector2.RIGHT,
			"spawn_conds": []
		}
	]
