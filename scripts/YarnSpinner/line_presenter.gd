extends Node

@export var character_name_label : RichTextLabel
@export var line_text_label : RichTextLabel
@export var presenter_control: Node 
@export var dialogue_control: Node

@export var use_typewriter:= true
@export var typewriter_speed:= 60

var _is_revealing:= false
var active_tween: Tween

signal dialogue_complete
signal line_complete

func _ready() -> void: 
	presenter_control.visible = false 
	dialogue_control.request_next_line.connect(_on_next_line_requested)

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
	
	if use_typewriter:
		await _run_typewriter(output_line)
	else:
		line_text_label.visible_characters = -1
	
	await line_complete

func _run_typewriter(text: String) -> void:
	_is_revealing = true
	
	line_text_label.visible_characters = 0
	
	var total_chars := text.length()
	var duration := float(total_chars) / typewriter_speed
	
	if active_tween:
		active_tween.kill()
	
	active_tween = create_tween()
	active_tween.tween_property(
		line_text_label,
		"visible_characters",
		total_chars,
		duration
	)
	
	await active_tween.finished
	
	_is_revealing = false

func _hurry_up_line():
	active_tween.emit_signal("finished")
	active_tween.kill()
	line_text_label.visible_characters = -1
	_is_revealing = false

func _on_next_line_requested():
	print("Next line requested")
	if _is_revealing:
		_hurry_up_line()
	else:
		emit_signal("line_complete")
