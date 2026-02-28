extends Location

@onready var uniform: Sprite2D = $Uniform

@onready var drawer: Area2D = $Interactables/Drawer
@onready var window: Area2D = $Interactables/Window
@onready var bookcase: Area2D = $Interactables/Bookcase

var cutscene_rules = [
	{
		"id": "pc_bedroom_intro",
		"conditions": [!Global_World_State.cutscenes.has("pc_bedroom_intro")]
	}
]

func _ready() -> void:
	# Adding failsafe to the inherited location scenes as spawn is no longer based on prev_scene but intended spawn
	super()
	var player_data = ResourceLoader.load("res://saves/player_data.tres")
	uniform.texture = load("res://assets/locations/brackenberry village/player home/body_type_%d.png" % [player_data.body_type])
	cutscenes = {
		"pc_bedroom_intro": [
				{"type": "dialogue", "dialogue_id": "chapter1_openingScene"},
				{"type": "transition", "transition_type": "fade_in", "duration": 2},
				{"type": "move", "actor": pc, "dir": Vector2.RIGHT},
				{"type": "move", "actor": pc, "dir": Vector2.RIGHT},
				{"type": "move", "actor": pc, "dir": Vector2.DOWN}
			]
		}

func get_cutscene_to_play():
	for rule in cutscene_rules:
		var conditions_met = 0
		for condition in rule["conditions"]:
			if condition:
				conditions_met =+ 1
		if conditions_met == rule["condition"].size():
			return rule["id"]
