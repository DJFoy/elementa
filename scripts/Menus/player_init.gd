extends Control

signal world_change_request(to_scene_path: String)


@onready var player_name: LineEdit = $ScrollContainer/ScrollLayer/PlayerName
@onready var pronouns: OptionButton = $ScrollContainer/ScrollLayer/Pronouns
@onready var body_type: ItemList = $ScrollContainer/ScrollLayer/BodyType
@onready var skin_tone_selector: Control = $ScrollContainer/ScrollLayer/SkinToneSelector
@onready var hair_style: ItemList = $ScrollContainer/ScrollLayer/HairStyle
@onready var hair_colour: ColorPickerButton = $ScrollContainer/ScrollLayer/HairColour
@onready var eye_colour: ColorPickerButton = $ScrollContainer/ScrollLayer/EyeColour
@onready var outfit: ItemList = $ScrollContainer/ScrollLayer/Outfit
@onready var likes: OptionButton = $ScrollContainer/ScrollLayer/Likes
@onready var dislikes: OptionButton = $ScrollContainer/ScrollLayer/Dislikes

@onready var portrait: Portrait = $ScrollContainer/ScrollLayer/Portrait
@onready var confirm: Button = $ScrollContainer/ScrollLayer/Confirm

var skin_tone_selected = false
var hair_colour_selected = false
var eye_colour_selected = false

@onready var preferences = [
	"Apple",
	"Aubergine",
	"Banana",
	"Blue Cheese",
	"Bread",
	"Cake",
	"Cheese",
	"Chocolate",
	"Coconut",
	"Duck a l'Orange",
	"Fish",
	"Ice Cream",
	"Liver",
	"Mushrooms",
	"Olives",
	"Pie",
	"Salad",
	"Sea Food",
	"Steak",
	"Strawberry",
	"Sushi"
]

func _ready() -> void:
	skin_tone_selector.connect("skin_tone_selected", _on_skin_tone_selected)
	populate_options(likes, preferences)
	populate_options(dislikes, preferences)

func populate_options(button: OptionButton, list: Array) -> void:
	button.clear()
	for item in list:
		button.add_item(item)
	button.selected = -1

func _on_skin_tone_selected(skin_index):
	if !skin_tone_selected:
		skin_tone_selected = true
	portrait.skin_colour_choice = skin_index + 1
	portrait.load_textures()

func _on_confirm_pressed() -> void:
	var player_settings:= PlayerCreationData.new()
	var invalid_checks := [
		player_name.text == "",
		pronouns.get_selected_id() == -1,
		!body_type.is_anything_selected(),
		!skin_tone_selected,
		!hair_style.is_anything_selected(),
		!hair_colour_selected,
		!eye_colour_selected,
		!outfit.is_anything_selected(),
		likes.get_selected_id() == -1,
		dislikes.get_selected_id() == -1,
		likes == dislikes,
	]
	
	if invalid_checks.any(func(v): return v):
		return
	
	player_settings.name = player_name.text
	player_settings.pronouns = pronouns.get_item_text(pronouns.get_selected_id())
	player_settings.body_type = portrait.body_type_choice
	player_settings.skin_colour = portrait.skin_colour_choice
	player_settings.hair = portrait.hair_choice
	player_settings.hair_colour = portrait.hair_colour_choice
	player_settings.eye_colour = portrait.eye_colour_choice
	player_settings.clothes = portrait.clothes_choice
	player_settings.likes = likes.get_item_text(likes.get_selected_id())
	player_settings.dislikes = dislikes.get_item_text(dislikes.get_selected_id())
	
	ResourceSaver.save(player_settings, "res://saves/player_data.tres")
	Global_World_State.character = ResourceLoader.load("res://saves/player_data.tres")
	
	Global.prev_scene = "PlayerInit"
	Global.target_spawn = "pc_bedroom_bed_01"
	Global.game_loaded = true
	world_change_request.emit("res://scenes/chapter1/locations/pc_bedroom.tscn")


func _on_body_type_item_selected(index: int) -> void:
	portrait.body_type_choice = index + 1
	portrait.load_textures()


func _on_hair_style_item_selected(index: int) -> void:
	portrait.hair_choice = index + 1
	portrait.load_textures()


func _on_hair_colour_color_changed(color: Color) -> void:
	if !hair_colour_selected:
		hair_colour_selected = true
	portrait.hair_colour_choice = color
	portrait.load_textures()
	for i in hair_style.item_count:
		hair_style.set_item_icon_modulate(i, color)
	
func _on_eye_colour_color_changed(color: Color) -> void:
	if !eye_colour_selected:
		eye_colour_selected = true
	portrait.eye_colour_choice = color
	portrait.load_textures()


func _on_outfit_item_selected(index: int) -> void:
	portrait.clothes_choice = index + 1
	portrait.load_textures()
