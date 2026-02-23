extends Control

@export var portrait: TextureRect
@export var presenter_control: Control

func _ready() -> void:
	presenter_control.visible = false

func on_dialogue_start_async() -> void:
	pass

func run_line_async(line: Dictionary) -> void:
	# line is a Dictionary converted from the LocalizedLine C# Class
	# converts to GDScript LocalizedLine
	var localized_line : YarnSpinner.LocalizedLine = YarnSpinner.LocalizedLine.from_dictionary(line)
	await _run_line_internal(localized_line)

func _run_line_internal(localized_line: YarnSpinner.LocalizedLine) -> void:
	presenter_control.visible = !localized_line.character_name.is_empty()
	portrait.texture = load("res://assets/character_assets/anne/Anne Overworld Sprite.png" % [localized_line.character_name])
