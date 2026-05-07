extends Character
class_name Non_Player_Character

@onready var main_sprite: Sprite2D = $MainSprite
@onready var accessory: Sprite2D = $Accessory
@onready var player_data := ResourceLoader.load("res://saves/player_data.tres")

@onready var skin_colour: Sprite2D = $NPCExtras/SkinColour
@onready var hair: Sprite2D = $NPCExtras/Hair
@onready var eye_colour: Sprite2D = $NPCExtras/EyeColour
@onready var top: Sprite2D = $NPCExtras/Top
@onready var bottoms: Sprite2D = $NPCExtras/Bottoms

@export var npc_resource: NPC_Resource

func _ready() -> void:
	actor_id = npc_resource.npc_name
	super()
	add_to_group("Dialogue")
	main_sprite.texture = npc_resource.get_sprite_texture(player_data.skin_colour)
	skin_colour.texture = npc_resource.skin_tone
	hair.texture = npc_resource.npc_hair
	hair.modulate = npc_resource.hair_colour
	eye_colour.texture = npc_resource.npc_eye
	eye_colour.modulate = npc_resource.eye_colour
	top.texture = npc_resource.npc_top
	bottoms.texture = npc_resource.npc_bottom
