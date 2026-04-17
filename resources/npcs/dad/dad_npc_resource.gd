extends NPC_Resource
class_name Dad_Resource

@export var variant_sprite: Array[Texture2D]
@export var variant_portrait: Array[Texture2D]

func get_sprite_texture(skin_colour: int):
	return variant_sprite[skin_colour - 1]

func get_portrait_texture(skin_colour: int):
	return variant_portrait[skin_colour - 1]
