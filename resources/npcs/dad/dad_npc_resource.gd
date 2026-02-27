extends NPC_Resource
class_name Dad_Resource

@export var variant_sprite: Array[Texture2D]
@export var variant_portrait: Array[Texture2D]

func get_sprite_texture(pc_body_type: int):
	return variant_sprite[pc_body_type - 1]

func get_portrait_texture(pc_body_type: int):
	return variant_portrait[pc_body_type - 1]
