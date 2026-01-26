extends Location

@onready var dad: Non_Player_Character = $NPCs/Dad
@onready var dad_sprite := preload("res://resources/character_sprite_tilesets/dad_sprite.tres")

func _ready() -> void:
	dad.get_node("Sprite2D").texture = dad_sprite
	super()
