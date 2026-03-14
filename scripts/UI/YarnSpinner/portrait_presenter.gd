extends Control

@export var npc_portrait: TextureRect
@export var presenter_control: Control

func _ready() -> void:
	presenter_control.visible = false

func on_dialogue_start_async() -> void:
	pass

func run_line_async(line: Dictionary) -> void:
	# line is a Dictionary converted from the LocalizedLine C# Class
	# converts to GDScript LocalizedLine
	var localized_line : YarnSpinner.LocalizedLine = YarnSpinner.LocalizedLine.from_dictionary(line)
	presenter_control.visible = !localized_line.character_name.is_empty()
	_run_line_internal(localized_line)

func _run_line_internal(localized_line: YarnSpinner.LocalizedLine) -> void:
	presenter_control.visible = !localized_line.character_name.is_empty()
	npc_portrait.texture = load("res://assets/character_assets/portraits/%s.png" % [resolve_character(localized_line)])


func resolve_character(localized_line: YarnSpinner.LocalizedLine) -> String:
	var character_name = localized_line.character_name.to_lower()
	
	return character_name + Global_World_State.get_character_portrait_variant(character_name)
