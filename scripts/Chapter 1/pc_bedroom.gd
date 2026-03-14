extends Location

@onready var uniform: Sprite2D = $Uniform

@onready var drawer: Area2D = $Interactables/Drawer
@onready var window: Area2D = $Interactables/Window
@onready var bookcase: Area2D = $Interactables/Bookcase 

@export var pc_bedroom_intro: Cutscene

func _ready() -> void:
	super()
	var player_data = ResourceLoader.load("res://saves/player_data.tres")
	cutscenes = {
		"pc_bedroom_intro": [
				CH.say("chapter1_openingScene"),
				CH.transition(TransitionStep.TransitionType.FADE_IN, 2),
				CH.turn(pc, Vector2.RIGHT),
				CH.move(pc, Vector2.RIGHT),
				CH.move(pc, Vector2.RIGHT),
				CH.turn(pc, Vector2.DOWN),
				CH.move(pc, Vector2.DOWN)
			]
		}
	cutscene_rules = [
		{
		"id": "pc_bedroom_intro",
		"conditions": [!Global_World_State.cutscenes.has("pc_bedroom_intro")]
		}
	]
	uniform.texture = load("res://assets/locations/brackenberry village/player home/body_type_%d.png" % [player_data.body_type])
	
