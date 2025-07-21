extends Control

@onready var player_name: LineEdit = $ScrollContainer/VBoxContainer/PlayerName
@onready var body_1: CheckBox = $ScrollContainer/VBoxContainer/BodyType1
@onready var body_2: CheckBox = $ScrollContainer/VBoxContainer/BodyType2
@onready var hair: OptionButton = $ScrollContainer/VBoxContainer/OptionButton

func _on_body_type_1_toggled(toggled_on: bool) -> void:
	if body_2.button_pressed:
		body_2.button_pressed = false
	body_1.set_pressed_no_signal(toggled_on)


func _on_body_type_2_toggled(toggled_on: bool) -> void:
	if body_1.button_pressed:
		body_1.button_pressed = false
	body_2.set_pressed_no_signal(toggled_on)


func _on_confirm_pressed() -> void:
	var player_settings:= PlayerCreationData.new()
	if player_name.text == "" || player_name.text == player_name.placeholder_text:
		print("Error, please enter your name")
	else:
		player_settings.name = player_name.text
	if body_1.button_pressed:
		player_settings.body_type = 1
	elif body_2.button_pressed:
		player_settings.body_type = 2
	else:
		print("Error, please choose a body type")
		return
	if hair.selected == -1:
		print("Error, please choose a hair type")
	else:
		player_settings.hair = hair.selected
	
	ResourceSaver.save(player_settings, "res://saves/player_data.tres")
	print("Body type " + str(player_settings.body_type))
	print("Name " + str(player_settings.name))
	print("Hair " + str(player_settings.hair))
