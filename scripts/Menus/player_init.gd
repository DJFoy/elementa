extends Control

@onready var player_name: LineEdit = $ScrollContainer/VBoxContainer/PlayerName
@onready var body_1: CheckBox = $ScrollContainer/VBoxContainer/BodyType1
@onready var body_2: CheckBox = $ScrollContainer/VBoxContainer/BodyType2
@onready var hair: OptionButton = $ScrollContainer/VBoxContainer/HairType
@onready var hair_colour: ColorPickerButton = $ScrollContainer/VBoxContainer/HairColour

@onready var pc: Node2D = $PC

func _ready() -> void:
	pc.get_node("Hair").modulate = hair_colour.color

func _on_body_type_1_toggled(toggled_on: bool) -> void:
	if body_2.button_pressed:
		body_2.button_pressed = false
	body_1.set_pressed_no_signal(toggled_on)


func _on_body_type_2_toggled(toggled_on: bool) -> void:
	if body_1.button_pressed:
		body_1.button_pressed = false
	body_2.set_pressed_no_signal(toggled_on)


func _on_hair_type_item_selected(index: int) -> void:
	pc.get_node("Hair").texture = pc.hair_dict[index]


func _on_hair_colour_color_changed(color: Color) -> void:
	pc.get_node("Hair").modulate = color

func _on_confirm_pressed() -> void:
	var player_settings:= PlayerCreationData.new()
	var inval: bool = false
	if player_name.text == "" || player_name.text == player_name.placeholder_text:
		inval = true
	if !body_1.button_pressed && !body_2.button_pressed:
		inval = true
	if hair.selected == -1:
		inval = true
	

	player_settings.name = player_name.text
	if body_1.button_pressed:
		player_settings.body_type = 1
	elif body_2.button_pressed:
		player_settings.body_type = 2
	player_settings.hair = hair.selected
	player_settings.hair_colour = hair_colour.color
	
	
	ResourceSaver.save(player_settings, "res://saves/player_data.tres")
	print("Body type " + str(player_settings.body_type))
	print("Name " + str(player_settings.name))
	print("Hair " + str(player_settings.hair))
	print("Hair Colour " + str(player_settings.hair_colour))
	
	get_tree().change_scene_to_file("res://scenes/chapter1/locations/pc_bedroom.tscn")
