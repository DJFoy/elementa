extends Node2D

class_name Portrait

@onready var skin: Sprite2D = $Skin
@onready var base: Sprite2D = $Base
@onready var skin_shadows: Sprite2D = $SkinShadows
@onready var eye_colour: Sprite2D = $EyeColour
@onready var eye_highlight: Sprite2D = $EyeHighlight
@onready var eye_whites: Sprite2D = $EyeWhites
@onready var hair: Sprite2D = $Hair
@onready var hair_shadows: Sprite2D = $HairShadows

@export var hair_choice: int = 1
@export var hair_colour_choice: Color = Color.WHITE
@export var eye_colour_choice: Color = Color.WHITE
@export var skin_colour_choice: int = 1
@export var body_type_choice: int = 1
@export var clothes_choice: int = 1

func _ready() -> void:
	if Global.game_loaded:
		var player_data = ResourceLoader.load("res://saves/player_data.tres")
		if player_data:
			apply_character_data(player_data)
	load_textures()

func get_portrait_asset(category: String, filename: String) -> String:
	return "res://assets/character_assets/pc_assets/portrait/body_type_%d/%s/%s.png" % [body_type_choice, category, filename]

func apply_character_data(data: PlayerCreationData):
	hair_choice = data.hair
	hair_colour_choice = data.hair_colour
	eye_colour_choice = data.eye_colour
	skin_colour_choice = data.skin_colour
	body_type_choice = data.body_type
	clothes_choice = data.clothes
	
func load_textures():
	skin.texture = load(get_portrait_asset("skin", "tone_%d" % skin_colour_choice))
	base.texture = load(get_portrait_asset("clothes", "outfit_%d" % clothes_choice))
	skin_shadows.texture = load(get_portrait_asset("shadows", "st%d" % skin_colour_choice))
	eye_colour.texture = load(get_portrait_asset("eyes", "eyes"))
	eye_colour.modulate = eye_colour_choice
	eye_highlight.texture = load(get_portrait_asset("eyes", "highlights"))
	eye_whites.texture = load(get_portrait_asset("eyes", "whites"))
	hair.texture = load(get_portrait_asset("hair", "h%d" % hair_choice))
	hair.modulate = hair_colour_choice
	hair_shadows.texture = load(get_portrait_asset("hair", "h%d_st%d_shadow" % [hair_choice, skin_colour_choice]))
