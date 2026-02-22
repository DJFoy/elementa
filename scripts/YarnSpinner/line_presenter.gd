extends Node

@export var character_name_label : RichTextLabel
@export var line_text_label : RichTextLabel
@export var presenter_control: Node 
@export var dialogue_control: Node

@export var use_typewriter:= true
@export var typewriter_speed:= 60

signal dialogue_complete

func _ready() -> void: 
	presenter_control.visible = false 

func on_dialogue_start_async() -> void:
	print("Dialogue started ")
	presenter_control.visible = true

func run_line_async(line: Dictionary) -> void:
	print('Line: ' + JSON.stringify(line))

	# line is a Dictionary converted from the LocalizedLine C# Class
	# converts to GDScript LocalizedLine
	var localized_line : YarnSpinner.LocalizedLine = YarnSpinner.LocalizedLine.from_dictionary(line)
	await _run_line_internal(localized_line)

func dialogue_complete_async() -> void:
	print("Dialogue complete ")
	emit_signal("dialogue_complete")

func _run_line_internal(localized_line: YarnSpinner.LocalizedLine) -> void:
	character_name_label.visible = !localized_line.character_name.is_empty()
	character_name_label.text = localized_line.character_name
	
	var output_line: String = localized_line.text_without_character_name.text

	line_text_label.text = output_line
	await dialogue_control.request_next_line
