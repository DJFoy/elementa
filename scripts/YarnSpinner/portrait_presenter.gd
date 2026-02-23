extends Control

@export var character_name_label: RichTextLabel
@export var portrait: TextureRect
@export var presenter_control: Control

func _ready() -> void:
	presenter_control.visible = false

func on_dialogue_start_async() -> void:
	print("Starting Dialogue from the Portrait container :/)")
	presenter_control.visible = true
