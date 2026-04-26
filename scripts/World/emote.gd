extends Node2D
class_name Emote

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var emote_resource: EmoteResource

func _ready() -> void:
	sprite_2d.texture = emote_resource.image
	animation_player.play(emote_resource.anim)
