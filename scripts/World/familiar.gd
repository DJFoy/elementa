extends Non_Player_Character
class_name Familiar

@export var familiar_resource: NPC_Resource

@export var target_char: Character

func _ready() -> void:
	main_sprite.texture = familiar_resource.sprite_sheet
