extends Resource
class_name NPC_Resource

@export var npc_name: String
@export var npc_sprite: Texture2D
@export var npc_portrait: Texture2D
@export var dialogue_map: DialogueMap

func get_sprite_texture(pc_body_type: int):
	return npc_sprite

func get_portrait_texture(pc_body_type: int):
	return npc_portrait
