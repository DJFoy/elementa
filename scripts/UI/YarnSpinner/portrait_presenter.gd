extends Control

@export var npc_portrait: TextureRect
@export var presenter_control: Control
@export var emotion: TextureRect
@export var emote: TextureRect

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
	
	var character_name = localized_line.character_name.to_lower()
	
	npc_portrait.texture = load("res://assets/character_assets/portraits/%s/%s.png" % [character_name, character_name + resolve_variant(character_name)])
	print("res://assets/character_assets/portraits/%s/%s.png" % [character_name, resolve_expression(localized_line) + resolve_variant(character_name)])
	print("res://assets/character_assets/portraits/%s.png" % [resolve_additions(localized_line) + resolve_variant(character_name)])
	emotion.texture = load("res://assets/character_assets/portraits/%s/%s.png" % [character_name, resolve_expression(localized_line) + resolve_variant(character_name)])
	emote.texture = load("res://assets/character_assets/portraits/%s.png" % [resolve_additions(localized_line)])

func resolve_variant(character_name: String) -> String:
	return Global_World_State.get_character_portrait_variant(character_name)


func resolve_expression(localized_line: YarnSpinner.LocalizedLine) -> String:
	for tag in localized_line.metadata:
		match tag:
			"worried_smile": return "worried_smile"
			"sad": return "sad"
			"cute_smile": return "cute_smile"
			"shocked": return "shocked"
			"overjoyed": return "overjoyed"
			"happy": return "happy"
	return ""

func resolve_additions(localized_line: YarnSpinner.LocalizedLine) -> String:
	for tag in localized_line.metadata:
		match tag:
			"sweatdrop": return "sweatdrop"
	return ""
