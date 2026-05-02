extends Character
class_name Non_Player_Character

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var player_data := ResourceLoader.load("res://saves/player_data.tres")

@export var npc_resource: NPC_Resource

func _ready() -> void:
	actor_id = npc_resource.npc_name
	super()
	add_to_group("Dialogue")
	sprite_2d.texture = npc_resource.get_sprite_texture(player_data.skin_colour)
